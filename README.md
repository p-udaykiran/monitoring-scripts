# 🛡️ System Monitoring & Automation Scripts

A curated collection of Bash shell scripts designed to simplify and automate various system administration tasks. These scripts are ideal for Linux system administrators, DevOps engineers, and anyone looking to monitor and maintain system health efficiently.

---

## 📁 Folder Structure

```
system-monitoring-scripts/
├── backup_mysql.sh                # Backup script for MySQL databases
├── system_info.sh                # Displays system information
├── clean_system.sh               # Cleans system junk, cache, and unused packages
├── uptime.sh                     # Displays system uptime
├── port_listing.sh               # Lists open and listening ports
├── auto_update.sh                # Automatically updates packages
├── http_response_time.sh         # Logs HTTP response time of a website
├── http_diff_response_time.sh    # Compares response times of two websites
├── process_memory_monitor.sh     # Monitors top resource-consuming processes
└── ...
```

---

## 🧰 Included Scripts

| Script Name                  | Description |
|-----------------------------|-------------|
| `backup_mysql.sh`           | Automates MySQL database backup with timestamp |
| `system_info.sh`            | Outputs CPU, memory, disk, and OS info |
| `clean_system.sh`           | Frees space by cleaning cache, unused packages, and old logs |
| `uptime.sh`                 | Displays uptime and load averages |
| `port_listing.sh`           | Lists all open TCP/UDP ports and listening services |
| `auto_update.sh`            | Updates system packages automatically (Debian-based) |
| `http_response_time.sh`     | Measures and logs website response time |
| `http_diff_response_time.sh`| Compares response times between two websites |
| `process_memory_monitor.sh` | Tracks top processes by memory and CPU usage |

---

## 🛠️ Requirements

Make sure the following tools/packages are installed:

- Bash Shell
- Linux OS (Ubuntu/Debian/CentOS)
- `curl`
- `awk`
- `lsof`
- `netstat`
- `top`
- `mysql`
- `grep`

---

## 🚀 Getting Started

Clone this repository to get started:

```bash
git clone https://github.com/p-udaykiran/system-monitoring-scripts.git
cd system-monitoring-scripts
```

Give execute permission and run any script:

```bash
chmod +x system_info.sh
./system_info.sh
```

---

## 🙌 Contributing

Contributions are welcome! Feel free to fork the repo, submit pull requests, or suggest new scripts and improvements.



---

## 👤 Author

**Uday Kiran**  
📧 [Email](mailto:udaypagidimari@gmail.com)  
🔗 [linkdin](https://www.linkedin.com/in/udaykiran-pagidimari-30275725a)
