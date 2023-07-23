module PetsHelper
  def sortable(column, title)
    direction = column == params[:sort_column] && params[:sort_direction] == 'asc' ? 'desc' : 'asc'
    link_to title, { sort_column: column, sort_direction: direction }, class: "text-decoration-none"
  end
end
