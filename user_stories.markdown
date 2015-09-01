As a user
When I submit a POST request to "/sources”
With an “identifier” set to “jumpstartlab”
And a “rootUrl” set to “help://jumpstartlab.com”
Then I should receive a response of 200 OK
And a response body of “{“identifier”:”jumpstartlab”}”

When I submit a POST request to “/sources”
And I am missing an “identifier” and “rootUrl”
Then I should receive response of 400 Bad Request

When I submit a POST request to “/sources”
With an “identifier” and “jumpstartlab”
And the “identifier” has already been taken
Then I should receive response of 403 Forbidden
And I should receive a descriptive error message

when i visit "/sources"
And I click "identifier" button
Then I should be redirected to "/sources/IDENTIFIER"

When I visit "/sources/IDENTIFIER"
Then the page should display "most requested urls: string(requested x times)"
Where x is integer

When I visit "/sources/IDENTIFIER"
Then the page should display "web browser breakdown: string(viewed x times per browser)"
Where x is integer

When I visit "/sources/IDENTIFIER"
Then the page should display "OS breakdown: string(viewed x times per OS)"
Where x is integer

When I visit "/sources/IDENTIFIER"
Then the page should display "screen resolution breakdown: string(viewed x times per resolutionWidth x resolutionHeight)"
Where x is integer

When I visit "/sources/IDENTIFIER"
Then the page should display "average response time per URL breakdown: string"
Where x is integer

When I visit "/sources/IDENTIFIER"
Then the page should display "hyperlinks of each url to view url specific data

When I visit "/sources/IDENTIFIER"
Then the page should display "hyperlink to view aggregate event data"

When I visit "/sources/IDENTIFIER"
And the identifier does not exist
Then the page should display "identifier does not exist"

When i visit "/sources/IDENTIFIER/urls/RELATIVE/PATH"
then i should see "Longest Response time:"integer""

When i visit "/sources/IDENTIFIER/urls/RELATIVE/PATH"
then i should see "Shortest Response time:"integer""

When i visit "/sources/IDENTIFIER/urls/RELATIVE/PATH"
then i should see "Average Response time:"integer""

When i visit "/sources/IDENTIFIER/urls/RELATIVE/PATH"
then i should see "HTTP Verbs:"verbs""

When i visit "/sources/IDENTIFIER/urls/RELATIVE/PATH"
then i should see "Top referrers:"String""

When i visit "/sources/IDENTIFIER/urls/RELATIVE/PATH"
then i should see "Top User Agents:"String""

When i visit "/sources/IDENTIFIER/urls/RELATIVE/PATH"
and the path doesnt exist
then i should see "The URL has not been requested"

When I visit "/sources/IDENTIFIER/events/EVENTNAME"
and the event is defined
then I should see an hour by hour breakdown ex: x shown at 1, etc..

When I visit "/sources/IDENTIFIER/events"
then I should see the most successful events through the most unsuccessful events

When I visit "sources"/IDENTIFIER/events"
and no events are defined
then I should see a message "No events have been defined"

When I visit "/sources/IDENTIFIER/events"
then I should see links for each event

When I visit "/sources?IDENTIFIER/events"
and I click a event link
then I should be redirected to "/sources/IDENTIFIER/events/EVENTNAME"

When I visit "/sources/IDENTIFIER/events/EVENTNAME"
and the event is defined
then I should see "received x times"

When I visit "/sources/IDENTIFIER/events/EVENTNAME"
and the event has not been defined
I should be redirected /sources/event-error

When I am redirected to /sources/event-error
I should see "No event with given name"

When I am redirected to /sources/event-error
I should have a link back to Application Events Index

When I am redirected to /sources/event-error
And I click the Application Events Index
I should be redirected to /sources/IDENTIFIER/events
