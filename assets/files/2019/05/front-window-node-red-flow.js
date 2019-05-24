[
    {
        "id": "416c832b.26763c",
        "type": "api-call-service",
        "z": "8fe75527.8b52c8",
        "name": "Scan front window camera",
        "server": "7df3a83b.0cce48",
        "service_domain": "image_processing",
        "service": "scan",
        "data": "{\"entity_id\":\"image_processing.tensorflow_front_window\"}",
        "mergecontext": "",
        "output_location": "payload",
        "output_location_type": "msg",
        "x": 340,
        "y": 140,
        "wires": [
            [
                "fbda1803.77f808"
            ]
        ]
    },
    {
        "id": "74851b74.a8cf34",
        "type": "function",
        "z": "8fe75527.8b52c8",
        "name": "Front window camera payload",
        "func": "var newMsg = {};\n\nnewMsg.payload = 'Your front window camera spotted someone while you were away!';\nnewMsg.topic = ' 🚪🚶Front door alert 🚪🚶';\nnewMsg.attachment = \"/tmp/tensorflow/front_window_latest.jpg\";\n\nreturn newMsg;\n",
        "outputs": 1,
        "noerr": 0,
        "x": 790,
        "y": 320,
        "wires": [
            [
                "23e3f99c.ae6f66"
            ]
        ]
    },
    {
        "id": "8ee69776.8f44e8",
        "type": "pushover",
        "z": "8fe75527.8b52c8",
        "name": "",
        "device": "",
        "title": "",
        "priority": "-2",
        "sound": "",
        "url": "",
        "url_title": "",
        "html": false,
        "x": 1000,
        "y": 360,
        "wires": []
    },
    {
        "id": "fbda1803.77f808",
        "type": "ha-get-entities",
        "z": "8fe75527.8b52c8",
        "server": "7df3a83b.0cce48",
        "name": "Check if person",
        "rules": [
            {
                "property": "entity_id",
                "logic": "is",
                "value": "image_processing.tensorflow_front_window",
                "valueType": "str"
            }
        ],
        "output_type": "array",
        "output_empty_results": false,
        "output_location_type": "msg",
        "output_location": "payload",
        "output_results_count": 1,
        "x": 300,
        "y": 200,
        "wires": [
            [
                "9569ef5f.67697",
                "63276c41.b0cbf4"
            ]
        ]
    },
    {
        "id": "ce837f77.b111c",
        "type": "switch",
        "z": "8fe75527.8b52c8",
        "name": "Confidence",
        "property": "payload[0].attributes.matches.person[0].score",
        "propertyType": "msg",
        "rules": [
            {
                "t": "gte",
                "v": "85",
                "vt": "str"
            },
            {
                "t": "else"
            }
        ],
        "checkall": "true",
        "repair": true,
        "outputs": 2,
        "x": 290,
        "y": 320,
        "wires": [
            [
                "febcfb13.24a868"
            ],
            [
                "8d2dcb71.5c3f68"
            ]
        ]
    },
    {
        "id": "23e3f99c.ae6f66",
        "type": "delay",
        "z": "8fe75527.8b52c8",
        "name": "",
        "pauseType": "rate",
        "timeout": "5",
        "timeoutUnits": "seconds",
        "rate": "1",
        "nbRateUnits": "5",
        "rateUnits": "minute",
        "randomFirst": "1",
        "randomLast": "5",
        "randomUnits": "seconds",
        "drop": true,
        "x": 800,
        "y": 360,
        "wires": [
            [
                "8ee69776.8f44e8"
            ]
        ]
    },
    {
        "id": "fbe769f.e5c7d98",
        "type": "switch",
        "z": "8fe75527.8b52c8",
        "name": "Area size",
        "property": "payload",
        "propertyType": "msg",
        "rules": [
            {
                "t": "gte",
                "v": "2",
                "vt": "num"
            },
            {
                "t": "else"
            }
        ],
        "checkall": "true",
        "repair": true,
        "outputs": 2,
        "x": 540,
        "y": 320,
        "wires": [
            [
                "74851b74.a8cf34"
            ],
            [
                "8911c3c6.00b2f"
            ]
        ]
    },
    {
        "id": "9569ef5f.67697",
        "type": "function",
        "z": "8fe75527.8b52c8",
        "name": "splitter",
        "func": "var outputMsgs = [];\n\nfor (i = 0; i < msg.payload[0].attributes.matches.person.length; i++) {\n    var newMsg = {\n        payload: [{\n            \"entity_id\": \"image_processing.tensorflow_front_window\",\n            \"state\": \"1\",\n            \"attributes\": {\n                \"matches\": {\n                    \"person\": [{\n                        \"score\": 0,\n                        \"box\": [\n                            0,\n                            0,\n                            0,\n                            0\n                        ]\n                    }]\n                },\n            },\n        }]\n    }\n    \n    newMsg.payload[0].attributes.matches.person[0] = msg.payload[0].attributes.matches.person[i];\n    \n    outputMsgs.push(newMsg);\n}\n\nreturn [outputMsgs];",
        "outputs": 1,
        "noerr": 0,
        "x": 270,
        "y": 260,
        "wires": [
            [
                "ce837f77.b111c"
            ]
        ]
    },
    {
        "id": "febcfb13.24a868",
        "type": "function",
        "z": "8fe75527.8b52c8",
        "name": "Area",
        "func": "height = msg.payload[0].attributes.matches.person[0].box[2] - msg.payload[0].attributes.matches.person[0].box[0];\nwidth = msg.payload[0].attributes.matches.person[0].box[3] - msg.payload[0].attributes.matches.person[0].box[1];\n  \nreturn {payload:height * width * 100};",
        "outputs": 1,
        "noerr": 0,
        "x": 530,
        "y": 260,
        "wires": [
            [
                "fbe769f.e5c7d98"
            ]
        ]
    },
    {
        "id": "c53c4b5a.5c82e8",
        "type": "poll-state",
        "z": "8fe75527.8b52c8",
        "name": "House empty?",
        "server": "7df3a83b.0cce48",
        "updateinterval": "5",
        "updateIntervalUnits": "seconds",
        "outputinitially": false,
        "outputonchanged": false,
        "entity_id": "input_boolean.home_occupied",
        "state_type": "str",
        "halt_if": "on",
        "halt_if_type": "str",
        "halt_if_compare": "is",
        "outputs": 2,
        "x": 110,
        "y": 140,
        "wires": [
            [
                "416c832b.26763c"
            ],
            []
        ]
    },
    {
        "id": "63276c41.b0cbf4",
        "type": "debug",
        "z": "8fe75527.8b52c8",
        "name": "Person Check",
        "active": false,
        "tosidebar": true,
        "console": false,
        "tostatus": false,
        "complete": "true",
        "targetType": "full",
        "x": 560,
        "y": 200,
        "wires": []
    },
    {
        "id": "8911c3c6.00b2f",
        "type": "debug",
        "z": "8fe75527.8b52c8",
        "name": "Too small",
        "active": true,
        "tosidebar": true,
        "console": false,
        "tostatus": false,
        "complete": "payload",
        "targetType": "msg",
        "x": 540,
        "y": 380,
        "wires": []
    },
    {
        "id": "8d2dcb71.5c3f68",
        "type": "debug",
        "z": "8fe75527.8b52c8",
        "name": "Not confident",
        "active": true,
        "tosidebar": true,
        "console": false,
        "tostatus": false,
        "complete": "true",
        "targetType": "full",
        "x": 290,
        "y": 380,
        "wires": []
    },
    {
        "id": "e13d632d.3f82b",
        "type": "comment",
        "z": "8fe75527.8b52c8",
        "name": "Scanning front window",
        "info": "",
        "x": 320,
        "y": 80,
        "wires": []
    },
    {
        "id": "9da4b764.54b7d8",
        "type": "inject",
        "z": "8fe75527.8b52c8",
        "name": "Manual",
        "topic": "",
        "payload": "",
        "payloadType": "date",
        "repeat": "",
        "crontab": "",
        "once": false,
        "onceDelay": 0.1,
        "x": 130,
        "y": 100,
        "wires": [
            [
                "416c832b.26763c"
            ]
        ]
    },
    {
        "id": "7df3a83b.0cce48",
        "type": "server",
        "z": "",
        "name": "Home Assistant",
        "legacy": false,
        "hassio": false,
        "rejectUnauthorizedCerts": true,
        "ha_boolean": "y|yes|true|on|home|open",
        "connectionDelay": true
    }
]