Gem::Specification.new do |s|
  s.name        = 'enigma'
  s.version     = '0.0.1'
  s.date        = '2013-09-30'
  s.summary     = "Etcd with Chef"
  s.description = "Provides Libraries to query and save to etcd based on the enigma project"
  s.authors     = ["Jim Rosser"]
  s.email       = "jarosser06@gmail.com"
  s.files       = ['lib/enigma.rb',
                   'lib/enigma/node.rb',
                   'lib/enigma/service.rb',
                   'lib/enigma/etcd.rb',
                   'lib/enigma/service/endpoint.rb']
  s.license     = 'mit'
  s.homepage    = 'https://github.com/enigmaproject/ruby-enigma'
  s.add_dependency 'etcd'
end
