
[1mFrom:[0m /home/mat/Documents/RORWorkshop/collateral-manager-team-echo/app/views/collaterals/index.html.erb:21 #<Class:0x00007fe33d8ea030>#_app_views_collaterals_index_html_erb__2315348460260024375_28120:

    [1;34m16[0m:   </tr>
    [1;34m17[0m:   </thead>
    [1;34m18[0m:   <tbody>
    [1;34m19[0m:   <% @tag_filters.each do |item| %>
    [1;34m20[0m:   <%binding.pry %>
 => [1;34m21[0m:   <td>
    [1;34m22[0m:     <% item.each do |n| %>
    [1;34m23[0m:       <div class="checkbox">
    [1;34m24[0m:         <%= check_box_tag "name[#{n}]", false %>
    [1;34m25[0m:         <%= label_tag "name[#{n}]", n[0] %>
    [1;34m26[0m:       </div>

