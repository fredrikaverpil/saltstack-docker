pkg:
  module.run:
    - name: pkg.refresh_db # sync winrepo from salt master

windows:
  pkg.installed:
    - pkgs:
      - FileZilla

