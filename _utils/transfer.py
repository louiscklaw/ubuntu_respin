#!/usr/env/python
import os, sys, re, subprocess
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
upload_command = ['curl','-v','--dump-header','--upload-file', zip_filename,f'https://transfer.sh/{zip_filename}']

zip_command_result = subprocess.check_output(zip_command)
upload_command_result = subprocess.check_output(upload_command).decode('utf-8')

print(upload_command_result)
slack_message(upload_command_result, "#travis-build-result")