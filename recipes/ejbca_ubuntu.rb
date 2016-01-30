include_recipe 'entropy'
include_recipe 'apt'

package 'openjdk-7-jdk'
package 'ant'
package 'ant-optional'
package 'unzip'
package 'ntp'

ark 'jboss' do
  action :put
  url 'http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz'
  path '/opt'
end

template '/etc/init.d/jboss' do
  source 'jboss7-init.erb'
  mode 0775
  owner 'root'
  group 'root'
  notifies :enable, 'service[jboss]'
end

service 'jboss' do
  action :start
end

ark 'ejbca' do
  action :put
  url 'http://downloads.sourceforge.net/project/ejbca/ejbca6/ejbca_6_3_1_1/ejbca_ce_6_3_1_1.zip'
  path '/opt'
end

java_properties '/opt/ejbca/conf/ejbca.properties' do
  property 'appserver.home', '/opt/jboss'
end

execute 'deploy ejbca' do
  command 'ant deploy'
  cwd '/opt/ejbca'
end

execute 'install ejbca' do
  command 'ant install'
  cwd '/opt/ejbca'
  notifies :restart, 'service[jboss]'
end
