#! /usr/bin/ruby
require 'alfred-3_workflow'

workflow = Alfred3::Workflow.new

output = %x{/usr/local/bin/heroku apps}
lines = output.split("\n")
cleaned_lines = lines.reject{|l| l.match('===')}
apps = cleaned_lines.map{|l| l.split.first}   

cleaned_lines.each do|l|
     workflow.result
        .uid(l.split.first)
        .title(l.split.first)
        .subtitle(l.split.last)
        .arg(l.split.first)
        .autocomplete(l.split.first)

end        

print workflow.output