base:
  '*': # These modules are going to be applied to all minions 
    - core # This is /salt/states/core.sls
  
  'os:(RedHat|CentOS)':
    - match: grain
    - repos.centos # /salt/states/repos/centos.sls

  'os:Windows':
    - match: grain
    - repos.windows # /salt/states/repos/windows.sls