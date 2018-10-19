---
title: "How I Dim My Hue Lights with a Plex Webhook"
date: "2018-10-18 16:47"
comments: true
image:
  path: /assets/img/2018/10/banner.jpg
  height: 398
  width: 700
alt: My Home Assistant dashboard
published: true
tag: "small project"
description: "How I use the new webhooks endpoints added to Home Assistant to trigger dimming the lights when my media starts on Plex."
---

Last week, the Home Assistant project launched webhooks triggers. This means a user could create an endpoint could be hit from an external source to trigger an automation.

On this [Home Assistant community post](https://community.home-assistant.io/t/plex-webhooks-wip/73095), rossdargan had this great idea to parse the incoming JSON, and push it back to the local MQTT server so it could be read properly by the automations. 


```yaml
{% raw %}
- id: '1539725480000'
  alias: Plex Webhook MQTT
  trigger:
    platform: webhook
    webhook_id: !secret plex_webhook
  action:
   - service: mqtt.publish
     data_template:
       topic: 'plex/update'
       payload_template: >
         {{ (trigger.data['payload'] | string)[12:][:-2] | replace ("\\\\", "\\") | replace ("\\\'", "'") | replace ("\\x","?") }}
{% endraw %}
```

```yaml
{% raw %}
- id: '1539522762000'
  alias: Plex State Toggle
  trigger:
    platform: mqtt
    topic: 'plex/update'
  condition:
    condition: and
    conditions:
    - condition: template
      value_template: "{{trigger.payload_json.Account['title'] == 'PLEX_USER' }}"
    - condition: template
      value_template: "{{trigger.payload_json.Player['uuid'] == 'PLAYER_UUID' }}"
    - condition: template
      value_template: "{{trigger.payload_json.event != 'media.scrobble'}}"
    - condition: template
      value_template: "{{trigger.payload_json.event != 'media.rate'}}"
  action:
    service_template: >
        {% if ((trigger.payload_json.event == 'media.play') or (trigger.payload_json.event == 'media.resume')) %}
          input_boolean.turn_on
        {% elif ((trigger.payload_json.event == 'media.pause') or (trigger.payload_json.event == 'media.stop')) %}
          input_boolean.turn_off
        {% endif %}
    entity_id: input_boolean.plex
{% endraw %}    
```
