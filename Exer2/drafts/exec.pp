node default {
}

node 'server.domain.net' {
  include accounts
  realize (Accounts::Virtual['johndoe'])
}