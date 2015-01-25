<?php 
require "core/config/config.inc.php";
$connect = mysql_connect("$database_server", "$database_user", "$database_password") or die("Ошибка!");
mysql_select_db($dbase, $connect);
$sql = "DROP TABLE $table_prefix"."access_actiondom,$table_prefix"."access_actions,$table_prefix"."access_category,$table_prefix"."access_context,$table_prefix"."access_elements,$table_prefix"."access_media_source,$table_prefix"."access_menus,$table_prefix"."access_permissions,$table_prefix"."access_policies,$table_prefix"."access_policy_template_groups,$table_prefix"."access_policy_templates,$table_prefix"."access_resource_groups,$table_prefix"."access_resources,$table_prefix"."access_templatevars,$table_prefix"."actiondom,$table_prefix"."actions,$table_prefix"."actions_fields,$table_prefix"."active_users,$table_prefix"."categories,$table_prefix"."categories_closure,$table_prefix"."class_map,$table_prefix"."content_type,$table_prefix"."context,$table_prefix"."context_resource,$table_prefix"."context_setting,$table_prefix"."dashboard,$table_prefix"."dashboard_widget,$table_prefix"."dashboard_widget_placement,$table_prefix"."document_groups,$table_prefix"."documentgroup_names,$table_prefix"."element_property_sets,$table_prefix"."extension_packages,$table_prefix"."fc_profiles,$table_prefix"."fc_profiles_usergroups,$table_prefix"."fc_sets,$table_prefix"."lexicon_entries,$table_prefix"."manager_log,$table_prefix"."media_sources,$table_prefix"."media_sources_contexts,$table_prefix"."media_sources_elements,$table_prefix"."member_groups,$table_prefix"."membergroup_names,$table_prefix"."menus,$table_prefix"."namespaces,$table_prefix"."property_set,$table_prefix"."register_messages,$table_prefix"."register_queues,$table_prefix"."register_topics,$table_prefix"."session,$table_prefix"."site_content,$table_prefix"."site_htmlsnippets,$table_prefix"."site_plugin_events,$table_prefix"."site_plugins,$table_prefix"."site_snippets,$table_prefix"."site_templates,$table_prefix"."site_tmplvar_access,$table_prefix"."site_tmplvar_contentvalues,$table_prefix"."site_tmplvar_templates,$table_prefix"."site_tmplvars,$table_prefix"."system_eventnames,$table_prefix"."system_settings,$table_prefix"."transport_packages,$table_prefix"."transport_providers,$table_prefix"."user_group_roles,$table_prefix"."user_group_settings,$table_prefix"."user_messages,$table_prefix"."user_settings,$table_prefix"."workspaces";
$result = mysql_query($sql, $connect);
if (false === $result)
   die ('Error database SQL query<br>');

$command="mysql -u$database_user -p$database_password --default-character-set=utf8 $dbase < dump.sql";
$output = shell_exec($command);
mysql_close($connect);

?>
