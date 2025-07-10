# EJMedia Client Network Monitoring Box

🚀 **Reliable, secure, proactive network monitoring — built by EJMedia**

This repository contains code snippets, scripts, and configuration examples for the **EJMedia Client LAN Monitoring Box**, a custom-built network monitoring solution we deploy to client sites.

---

## 📡 About the box

The **Monitoring Box** is a small, hardened Linux device that sits on a client’s local network. It continuously monitors:

- Internet connectivity & stability
- Key internal network devices (firewalls, switches, WiFi controllers, servers)
- New devices appearing on the LAN
- Unusual network activity or unexpected open ports
- Historical uptime & availability for compliance reporting

**Hardware:**  
- Typically built on a **compact, energy-efficient mini PC**.  
- Specs are modest (2–4 cores, 8GB+ RAM, SSD), but provide plenty of headroom for proactive monitoring tasks.  
- We can deploy on nearly any modern mini system — it doesn’t require specialized or expensive proprietary hardware.

👉 [Browse typical mini PCs on Amazon](https://amzn.to/44Kq2xD)

**Software stack:**  
- Ubuntu Server 24.04.2 LTS (hardened & auto-updated for security)
- Our own Bash, Python, and NodeJS scripts to handle network scans, checks, reporting, and secure outbound connectivity.

**Architecture:**  
- These devices act strictly as **reporting nodes**.  
- They gather network health, device status, and scan data, then securely send it back to our central servers.
- Our core platform (running our own custom code and configurations) performs the heavy analysis, trend reporting, and advanced alerting.
- This ensures your network remains private — with no sensitive business files or content ever touched.

---

## 🔍 Live client instructions
We also maintain a public-facing page for our clients, explaining what the device does, how to install it, and how it protects their network:

👉 [https://ejmedia.ca/client-lan-monitor](https://ejmedia.ca/client-lan-monitor)

---

## 🛠 What’s in this repo

This repo will house:

- Example Bash and Python scripts for:
  - Periodic network scans (e.g. `nmap`) to detect open services
  - Parsing and summarizing results
  - Feeding data into Zabbix or other systems via `zabbix_sender`
- Sample `crontab` and systemd snippets for automated scheduling
- Hardened firewall & system config examples
- Reporting / HTML page builders for local network visibility

---

## 💡 Why open-source some of this?

At EJMedia, we believe in:

- **Transparency:** Showing the technical community how we build secure, proactive monitoring solutions.
- **Trust:** Clients and peers can see we’re using industry best practices.
- **Skills showcase:** This is also a window into the type of custom infrastructure automation & network security work we do.

---

## 🏢 About EJMedia

We build tailored network & cybersecurity solutions for businesses across Canada and beyond. From advanced monitoring & alerting to custom-built security tools and proactive IT care, we help keep your business running securely and smoothly.

🌐 [https://ejmedia.ca](https://ejmedia.ca)

---

## 🚀 Want something like this?

If you’re looking for:

- Dedicated network monitoring built around *your* environment
- Custom Linux, Python, NodeJS, or Bash tools
- Ongoing managed IT & cybersecurity support

📞 [Contact us at EJMedia](https://ejmedia.ca) — we’d love to discuss how we can help.

---

## 📜 License

This repository may include code samples released under a permissive open source license (MIT or Apache 2.0). See individual files for details.

---
