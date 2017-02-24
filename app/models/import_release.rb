class ImportRelease

  attr_accessor :version

  # If you create a new table not releated to the child nutrition database, it must be added here. Tables not in this
  # array will be deleted on each import
  NON_CND_DATABASES = ["schema_migrations", "users", "releases"]

  def initialize with_alcohol = false
    path = Rails.root.join("vendor", "releases")
    @latest_release_file = Dir.glob(File.join(path, '*.sql')).sort.max
    @version = @latest_release_file.match(/CN(.+).sql/)[1]
    @with_alcohol = with_alcohol
  end

  def perform
    if Release.find_by(version: @version)
      return "Release Already Exists" 
    else
      sync_database
    end
  end

  private

  def sync_database 
    connection = ActiveRecord::Base.connection

    ActiveRecord::Base.transaction do
      clear_cnd_tables(connection)

      sql = File.read(@latest_release_file)
      statements = sql.split(/;$/)
      statements.pop

      import_tables(statements, connection)
      Release.create(version: @version)
      remove_alcohol
    end
  end 

  def clear_cnd_tables connection
    connection.tables.each do |table|
      connection.execute("TRUNCATE #{table}") unless NON_CND_DATABASES.include?(table)
    end
  end

  def import_tables statements, connection
    statements.each do |statement|
      rails_clean_statement = statement
      [
        ["\"BUYGD\"","\"buygd\""],
        ["\"BYGDLNK\"","\"bygdlnk\""],
        ["\"CTGNME\"","\"ctgnme\""],
        ["\"FDES\"","\"fdes\""],
        ["\"NUTDES\"","\"nutdes\""],
        ["\"NUTVAL\"","\"nutval\""],
        ["\"WGHT\"","\"wght\""]
      ].each do |table_name|
        rails_clean_statement = rails_clean_statement.gsub(table_name[0], table_name[1])
      end
      connection.execute(rails_clean_statement)
    end
  end

  def remove_alcohol
    if !@with_alcohol
      Fdes.where("\"Descriptor\" LIKE ?", "Alcoholic beverage%").destroy_all
    end
  end
end
