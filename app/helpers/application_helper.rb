module ApplicationHelper
  def sortable(kclass, column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column(kclass) ? "current #{sort_direction}" : nil
    direction = column == sort_column(kclass) && sort_direction == "asc" ? "desc" : "asc"
    options = params.merge({:sort => column, :direction => direction})
    link_to title, options, {:class => css_class}
  end

  def get_col_value(kclass, column)
    kclass.public_send(column)
  end
end
