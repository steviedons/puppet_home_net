class localusers {
  user { 'admin':
    ensure     => present,
    shell      => '/bin/shell',
    home       => '/home/admin',
    gid        => 'wheel',
    managehome => true,
    password   => '$6$9oEtZVi1$MEHcx4PbHsu81cDb2EJPElBOMHDQkIg4Bjn.hifQ8aFVnT9tFrVqbvJXl6DJ5ncJC0m5wuzMf61u/qtDXmp291',
  }
}
