# <% count_of_responses = response_list.inject(Hash.new(0)) {|total, e| total[e] += 1 ;total}.sort_by {|key, value| -value} %>
# <% count_of_responses.each do |response, count| %>
#  <p>
#   <%= response %>
#   <%=": Was requested #{count} time(s)" %>
#  </p>
#  <br>
# <% end %>
