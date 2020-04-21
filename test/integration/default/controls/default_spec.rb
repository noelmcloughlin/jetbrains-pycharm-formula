# frozen_string_literal: true

title 'pycharm archives profile'

control 'pycharm archive' do
  impact 1.0
  title 'should be installed'

  describe file('/etc/default/pycharm.sh') do
    it { should exist }
  end
  # describe file('/usr/local/jetbrains/pycharm-C-*/bin/pycharm.sh') do
  #   it { should exist }
  # end
  describe file('/usr/share/applications/pycharm.desktop') do
    it { should exist }
  end
  describe file('/usr/local/bin/pycharm') do
    it { should exist }
  end
end
