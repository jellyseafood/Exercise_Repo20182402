# Used to define/realize users on Puppet-managed systems
#
class accounts {

  @accounts::virtual { 'johndoe':
    uid             =>  1001,
    realname        =>  'John Doe',
    pass            =>  '<password hash goes here>',
  }
}