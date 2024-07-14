declare
    l_request_url varchar2(32767);
    l_content_length number;
    l_response clob;
    upload_failed_exception exception;
    l_request_object blob;
    l_request_filename varchar2(500);
    l_request_url_xml varchar2(255);
    l_request_object_xml clob;
begin

    SELECT blob_content, filename 
    into l_request_object, l_request_filename
    from apex_application_temp_files 
    where name = :P14_FILE;

    l_request_url := :G_BASE_URL || '/b/fbcwh-podcasts/o/' || apex_util.url_encode(l_request_filename);

    l_response := apex_web_service.make_rest_request(
        p_url => l_request_url,
        p_http_method => 'PUT',
        p_body_blob => l_request_object,
        p_credential_static_id => 'OCI_API_ACCESS'
    );

    INSERT INTO PODCAST_EPISODES("URL", "NAME", "DESCRIPTION","DURATION_MINUTES","FILE_SIZE","PODCAST_ID",
    "PUBLICATION_DATE")
    SELECT :BLOB_PREFIX_PUBLIC_URL || l_request_filename, 
        :P14_TITLE, :P14_DESCRIPTION, :P14_DURATION_MINUTES,
        dbms_lob.getlength(l_request_object),
        1, :P14_PUBLICATION_DATE
    FROM DUAL;


    SELECT xmlContentRss
    into l_request_object_xml
    FROM V_RSS_FEED_CONTENT r;
    
    l_request_url_xml := :G_BASE_URL || '/b/fbcwh-podcasts/o/rss.xml';

    apex_web_service.set_request_headers(
                p_name_01        => 'Content-Type',
                p_value_01       => 'application/xml' );

    l_response := apex_web_service.make_rest_request(
        p_url => l_request_url_xml,
        p_http_method => 'PUT',
        p_body => l_request_object_xml,
        p_credential_static_id => 'OCI_API_ACCESS'
    );
end;