class OrganizationPresenter < BasePresenter
  # attr_reader :resource
  # delegate [:id, :name, :inn, :ogrn], to: :resource

  COLUMNS = [
    { name: :name, field: :name, label: 'Name', align: 'left', sortable: true },
    { name: :kind, field: :kind, label: 'Kind', align: 'left', sortable: true },
    { name: :inn, field: :inn, label: 'ИНН' },
    { name: :ogrn, field: :ogrn, label: 'ОГРН' },
    { name: :action, label: '', align: 'left' }
  ]

  def columns
    COLUMNS
  end

  def columns_keys
    COLUMNS.map { |column| column[:name] }
  end

  def actions
    [
      { name: :edit, label: 'Edit', icon: 'fas fa-edit' },
      { name: :delete, label: 'Delete', icon: 'fas fa-trash' }
    ]
  end

  def meta
    {
      columns: columns,
      columns_keys: columns_keys,
      actions: actions
    }
  end
end
