Gem::Specification.new do |s|
  s.name        = 'enigma'
  s.version     = '0.0.1'
  s.date        = '2013-09-30'
  s.summary     = "Etcd with Chef"
  s.description = "Provides Libraries to query and save to etcd based on the enigma project"
  s.authors     = ["Jim Rosser"]
  s.email       = "jarosser06@gmail.com"
  s.files       = ['lib/frosty.rb',
                   'lib/frosty/node.rb',
                   'lib/frosty/service.rb',
                   'lib/frosty/etcd.rb',
                   'lib/frosty/service/endpoint.rb']
  s.license     = 'mit'
  s.homepage    = 'https://github.com/enigmaproject/frosty'
  s.add_dependency 'etcd'
end
