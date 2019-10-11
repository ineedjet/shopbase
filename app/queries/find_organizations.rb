class FindOrganizations
  attr_accessor :initial_scope #, :pagination, :filter

  def initialize(initial_scope, params)
    @initial_scope = initial_scope
    @params = params
    @pagination = {}
    @filter = ""
  end

  def call(params)
    scoped = initial_scope
    scoped = search(initial_scope)
    scoped = sort(scoped)
    scoped = paginate(scoped)
    scoped
  end

  def meta
    { pagination: @pagination, filter: @filter }
  end

  private

  def search(scoped)
    @filter = @params[:filter] || ""
    @filter.present? ? scoped.search(@filter) : scoped
  end

  def sort(scoped)
    @pagination[:sortBy] = @params[:sortBy] || :name
    @pagination[:descending] = @params[:order] || :desc
    @pagination[:descending] = "desc" unless ["asc", "desc"].include?(@pagination[:descending].downcase)
    scoped.order(@pagination[:sortBy] => @pagination[:descending])
  end

  def paginate(scoped) #, page_number, rowsPerPage
    @pagination[:rowsNumber] = scoped.count
    @pagination[:page] = @params[:page] || 1
    @pagination[:rowsPerPage] = @params[:rowsPerPage] || 5
    scoped.page(@pagination[:page]).per(@pagination[:rowsPerPage])
  end
end
