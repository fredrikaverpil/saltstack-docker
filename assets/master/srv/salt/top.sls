base:
#  '*':
#    - core

  'os:(Centos|RedHat)':
    - match: grain
    - repos.centos

  'os:Windows':
    - match: grain
    - repos.windows
