namespace :db do
  desc "Run RAILS_ENV=#{Rails.env} ridgepole, annotate"
  task :ridgepole do
    schema_file = 'db/Schemafile'
    if Rails.env.development?
      lines = []
      Dir.glob(Rails.root.join('db', 'schema', '*.rb')) do |file|
        basename = File.basename(file)
        lines << "require 'schema/#{basename}'"
      end
      lines.sort!
      File.open(Rails.root.join(schema_file), "w") do |f|
        f.puts(lines.join("\n"))
      end
    end
    sh "bundle exec ridgepole -c config/database.yml -E #{Rails.env} --apply -f #{schema_file}"
    sh "bundle exec annotate" if Rails.env.development?
  end
end
