# Monitoring

## Solution

We use prometheus (https://prometheus.io/docs/prometheus/latest/getting_started/) for monitoring. 

**Note:** Here we only install the node exporter of prometheus. Nothing else.

## How to run

In your roster file (/etc/salt/roster), create hostname with the machine information

Ex:
```
tomonitor:
  host: 192.168.1.42    # The IP addr or DNS hostname
  user: foo             # Remote executions will be executed as user foo
  passwd: bar           # The password to use for login, if omitted, keys are used
  sudo: True            # Whether to sudo to root, not enabled by default
  tty: True             # TTY for allow sudo access
```

After that, you can run `salt-ssh -i tomonitor state.highstate`. 

If you want to see log, go on the port 9100 of your ip (ex: http://192.168.1.42:9100).

## Ressources:

- https://www.digitalocean.com/community/tutorials/how-to-use-prometheus-to-monitor-your-ubuntu-14-04-server
- https://www.techrepublic.com/article/how-to-install-the-prometheus-monitoring-system-on-ubuntu-16-04/
