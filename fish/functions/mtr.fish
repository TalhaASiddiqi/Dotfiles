function mtr
  if test (count $argv) -ne 2
    echo "Usage: mtr <service_name> <tags>"
    return 1
  end

  set service_name $argv[1]
  set tags $argv[2]

  gcloud run services update-traffic $service_name $tags --region us-central1
end
