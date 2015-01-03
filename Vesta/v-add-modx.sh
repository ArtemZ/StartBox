# Adding php wrapper
user="$1"
domain="$2"
ip="$3"
home_dir="$4"
docroot="$5"
#modx_link="http://modx.com/download/latest/"
modx_path="/home/$user/web/$domain/public_html"
#modx_file="$modx_path/modx.zip"
modx_password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 9 | head -n 1)
modx_database=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 4 | head -n 1)
modx_database_user=$user"_"$modx_database
cd $home_dir
#wget $modx_link -O $modx_file
#unzip $modx_file -d $modx_path
cp -R /home/admin/modx/* $modx_path
mv $modx_path/ht.access $modx_path/.htaccess
rm  $modx_path/index.html
$VESTA/bin/v-add-database $user $modx_database $modx_database $modx_password
echo "<modx>
<database_type>mysql</database_type>
<database_server>localhost</database_server>
<database>$user"_"$modx_database</database>
<database_user>$user"_"$modx_database</database_user>
<database_password>$modx_password</database_password>
<database_connection_charset>utf8</database_connection_charset>
<database_charset>utf8</database_charset>
<database_collation>utf8_unicode_ci</database_collation>
<table_prefix>modx_</table_prefix>
<https_port>443</https_port>
<http_host>$domain</http_host>
<cache_disabled>0</cache_disabled>
<inplace>1</inplace>
<unpacked>0</unpacked>
<language>ru</language>
<cmsadmin>admin</cmsadmin>
<cmspassword>admin</cmspassword>
<cmsadminemail>admin@$domain</cmsadminemail>
<core_path>/home/$user/web/$domain/public_html/core/</core_path>
<context_mgr_path>/home/$user/web/$domain/public_html/manager/</context_mgr_path>
<context_mgr_url>/manager/</context_mgr_url>
<context_connectors_path>/home/$user/web/$domain/public_html/connectors/</context_connectors_path>
<context_connectors_url>/connectors/</context_connectors_url>
<context_web_path>/home/$user/web/$domain/public_html/</context_web_path>
<context_web_url>/</context_web_url>
<remove_setup_directory>1</remove_setup_directory>
</modx>" > /home/$user/web/$domain/public_html/config.xml
php /home/$user/web/$domain/public_html/setup/index.php --installmode=new --config=/home/$user/web/$domain/public_html/config.xml
rm -rf $modx_path/core/cache
mysql -D $user"_"$modx_database "-u"$user"_"$modx_database "-p"$modx_password -e "drop tables modx_access_actiondom,modx_access_actions,modx_access_category,modx_access_context,modx_access_elements,modx_access_media_source,modx_access_menus,modx_access_permissions,modx_access_policies,modx_access_policy_template_groups,modx_access_policy_templates,modx_access_resource_groups,modx_access_resources,modx_access_templatevars,modx_actiondom,modx_actions,modx_actions_fields,modx_active_users,modx_categories,modx_categories_closure,modx_class_map,modx_content_type,modx_context,modx_context_resource,modx_context_setting,modx_dashboard,modx_dashboard_widget,modx_dashboard_widget_placement,modx_document_groups,modx_documentgroup_names,modx_element_property_sets,modx_extension_packages,modx_fc_profiles,modx_fc_profiles_usergroups,modx_fc_sets,modx_lexicon_entries,modx_manager_log,modx_media_sources,modx_media_sources_contexts,modx_media_sources_elements,modx_member_groups,modx_membergroup_names,modx_menus,modx_namespaces,modx_property_set,modx_register_messages,modx_register_queues,modx_register_topics,modx_session,modx_site_content,modx_site_htmlsnippets,modx_site_plugin_events,modx_site_plugins,modx_site_snippets,modx_site_templates,modx_site_tmplvar_access,modx_site_tmplvar_contentvalues,modx_site_tmplvar_templates,modx_site_tmplvars,modx_system_eventnames,modx_system_settings,modx_transport_packages,modx_transport_providers,modx_user_group_roles,modx_user_group_settings,modx_user_messages,modx_user_settings,modx_workspaces"
mysql "-u"$user"_"$modx_database "-p"$modx_password --default-character-set=utf8 $user"_"$modx_database < /home/admin/55tb_startbox_2014-11-23_13-51-28.sql
chown -R $user:$user /home/$user/web
echo Database: $user"_"$modx_database Password: $modx_password
