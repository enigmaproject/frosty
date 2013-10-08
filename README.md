SwedishChef
============

This is built around the Enigma infrastructure standards and is
meant to be used in chef cookbooks and as part of a knife plugin.


Ruby gem to handle passing and retrieving node and 
service information from and to etcd

Ex:
```ruby
swedish = SwedishChef.new(etcd_ip, etcd_port)
swedish.environment = 'production'

node = swedisch.node('node1')
service = swedish.service('memcached')

service.endpoints <- returns an array of endpoints

endpoint1 = service.endpoints[1]

## Below should throw an error if no other endpoint exists to promote
service.demote_endpoint(endpoint1) <- should select a new master and demote the old
service.save()

## print the role of each endpoint
service.endpoints.each do |endpoint|
  puts endpoint.role

  ## promote all nodes not already master
  unless endpoint.role == 'master'
    service.promote_endpoint(endpoint)
  end
end
```

The result should be that the node gets registered/checks in to etcd.

If the service did not already exist in the environment then the first
node to create the service by checking in will be declared master.

both the node and service will be registered under environment in etcd/keys
like etcd/keys/production/services/memcached and etcd/keys/production/nodes/ip

storage for our environment is another interesting challenge and while it is
a service it should also be a seperate entity.

etcd/keys/production/storage/jira_data/master <- master storage server hosting jira_data
etcd/keys/production/storage/jira_data/slaves/host1/last_sync <- 20130930012145

storage can and should be declared similarly to declaring a service.
