#! /usr/bin/ruby
require 'alfred-3_workflow'
require 'yaml'
require './app.rb'

APPS_LIST_FILE = 'app_list_cache.yml'
RELOAD_ARG = '--reload-apps'
@workflow = Alfred3::Workflow.new

def update_apps_list
  output = %x{/usr/local/bin/heroku apps}
  lines = output.split("\n")
  cleaned_lines = lines.reject{|l| l.match('===')}
  apps = cleaned_lines.map{|l| {name: l.split.first, info: l.split.last}}

  File.open(APPS_LIST_FILE, 'w') { |f| f.write(apps.to_yaml) }

  apps
end

def apps_list_cached
  YAML.load_file(APPS_LIST_FILE)
end

def apps_list
  apps = apps_list_cached
  !apps || apps&.empty? ? update_apps_list : apps
end

def build_app_menu
  apps_list.each do|app|
    @workflow.result
      .uid(app[:name])
      .title(app[:name])
      .subtitle(app[:info])
      .arg(app[:name])
      .autocomplete(app[:name])
  end        
end

if ARGV.count == 0
  build_app_menu
  print @workflow.output
else
  if ARGV.first ==  RELOAD_ARG
    update_apps_list
  else
    App.new(name: ARGV.first).action_menu(@workflow)
    print @workflow.output     
  end
end