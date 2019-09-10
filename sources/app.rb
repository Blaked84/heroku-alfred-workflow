class App 
  attr_accessor :name, :info

  def initialize(name:nil, info:nil)
    @name = name
    @info = info
  end

  def action_menu(workflow)
    workflow.result
      .uid('bash')
      .title('Bash')
      .arg("heroku run bash  --app #{@name}")
   
    workflow.result
      .uid('logs')
      .title('Logs')
      .arg("heroku logs -t --app #{@name}")

    workflow.result
      .uid('dashboard')
      .title('Dashboard')
      .arg("open https://dashboard.heroku.com/apps/#{@name}")  

    workflow.result
      .uid('app')
      .title('Open app')
      .arg("heroku apps:open --app #{@name}")

    workflow.result
      .uid('rails console')
      .title('Rails Console')
      .arg("heroku run rails console  --app #{@name}") 

    workflow.result
      .uid('pg info')
      .title('Postgres info')
      .arg("heroku pg:info  --app #{@name}")      
  end            
end
