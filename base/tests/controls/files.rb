# encoding: utf-8
# copyright: 2017, DeBankeGroup

title 'Files copied'

control 'beaver' do
  impact 1
  title 'beaver'
  desc 'Beaver Configured'
  describe file('/etc/beaver.conf') do
   it { should exist }
  end

  describe file('/etc/sv/beaver') do
    it { should exist }
  end

  describe file('/etc/apt/sources.list') do
    it { should exist }
  end

  describe file('/etc/service/dnsmasq') do
    it { should exist }
  end
end

control 'init and confd configuration' do
  describe file('/etc/my_init.d') do
    it { should exist }
  end

  describe file('/etc/confd') do
    it { should exist }
  end

  describe file('/scripts/base') do
    it { should exist }
  end
end

control 'contabs' do
  describe file('/etc/crontab') do
    it { should exist }
  end

  describe file('/var/spool/cron/crontabs/root') do
    it { should exist }
  end

  describe file('/var/spool/cron/crontabs/app') do
    it { should exist }
  end
end
