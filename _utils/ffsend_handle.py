#!/usr/env/python
import os,sys, subprocess
import slack

SLACK_TOKEN = os.environ['SLACK_TOKEN']

def slack_message(message, channel):
  client = slack.WebClient(token=SLACK_TOKEN)
  response = client.chat_postMessage(
      channel=channel,
      text=message,
      username='TravisMergerBot',
      icon_url=':sob:'
      )

target_filename = sys.argv[1]
zip_filename = os.path.basename(target_filename)+'.7z'

zip_command = ['7za', '-p1233211234567', 'a', zip_filename, target_filename, '-mx=9']
print(zip_command)

upload_command = ['ffsend', zip_filename]
print(upload_command)

zip_command_result = subprocess.check_output(zip_command)
upload_command_result = subprocess.check_output(upload_command).decode('utf-8')

upload_link=upload_command_result.split('\n')[3]

upload_link_text = 'upload_link: {}'.format(upload_link)
print(upload_link_text)

slack_message(upload_link_text, "#travis-build-result")
