class FindOrganizations
  attr_accessor :initial_scope

  def initialize(initial_scope)
    @initial_scope = initial_scope
  end

  def call(params)
    scoped = initial_scope
    scoped = search(initial_scope, params[:filter])
    scoped = sort(scoped, params[:sortBy], params[:descending])
    scoped = paginate(scoped, params[:page], params[:rowsPerPage])
    scoped
  end

  private

  def search(scoped, query = nil)
    # query ? scoped.where("title ILIKE '%?%'", query) : scoped
    query.present? ? scoped.search(query) : scoped
  end

  def sort(scoped, sort_type, sort_direction)
    direction = "desc" unless ["asc", "desc"].include?(sort_direction.downcase)
    scoped.order((sort_type || :name) => direction)
  end

  def paginate(scoped, page_number, per)
    scoped.page(page_number || 0).per(per || 5)
  end
end
