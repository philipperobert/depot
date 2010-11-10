# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

def fmt_dollars(amt)
  sprintf("$%0.2f", amt)
end


def reset_index_visits 
    session[:counter]=0
end
 
def count_index_visits 
    if session[:counter].nil? 
        reset_index_visits
    else
        session[:counter]+=1
    end
end
 
def report_index_visits
    if session[:counter]==0 then
        reponse="Welcome!"
    else
        response="Back for your "+session[:counter].to_s+"th visit?"
    end
    return response
end


end
