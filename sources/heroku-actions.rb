#! /usr/bin/ruby
require 'alfred-3_workflow'
workflow = Alfred3::Workflow.new

app_name = ARGV.first
workflow.result
  .uid('console')
  .title('Console')
  .arg("heroku console  --app #{app_name}")
   
workflow.result
  .uid('logs')
  .title('Logs')
  .arg("heroku logs -t --app #{app_name}")

workflow.result
  .uid('dashboard')
  .title('Dashboard')
  .arg("open https://dashboard.heroku.com/apps/#{app_name}")  

workflow.result
  .uid('app')
  .title('Open app')
  .arg("open http://#{app_name}.herokuapp.com")   

print workflow.output
