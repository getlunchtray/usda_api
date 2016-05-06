class ImportRelease
  def self.perform
    path = Rails.root.join("vendor", "releases")
    latest = Dir.glob(File.join(path, '*.*')).max { |a,b| File.ctime(a) <=> File.ctime(b) }
    version = latest.match(/CN(.+).sql/)[1]
    return "Release Already Exists" if Release.find_by(version: version)
    connection = ActiveRecord::Base.connection
    connection.tables.each do |table|
      connection.execute("TRUNCATE #{table}") unless table == "schema_migrations" || table == "releases"
    end

    sql = File.read(latest)
    statements = sql.split(/;$/)
    statements.pop

    ActiveRecord::Base.transaction do
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
      Release.create(version: version)
    end
  end 
end
