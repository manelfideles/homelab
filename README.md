### **Homelab Setup Documentation**

#### **1. Preparation Script (`setup.sh`)**

Run this script first to create all necessary folders and set permissions.

```bash
#!/bin/bash
# Homelab Directory Setup Script

# Create folder structure
mkdir -p ~/homelab/{config/{jellyfin,immich,n8n,radarr,prowlarr,qbittorrent,vaultwarden,bazarr,unmanic},data/{movies,tvshows,photos,downloads,vault},cache/unmanic}

# Set permissions for your user
sudo chown -R $USER:$USER ~/homelab
chmod -R 755 ~/homelab

echo "✅ Environment prepared in ~/homelab"
```

---

#### **3. Step-by-Step Setup Guide**

1. **Deploy:** Run `docker compose up -d`.
2. **Cloudflare Config:** Map your subdomains (`movies`, `vault`, `home`, `photos`) to their respective container names and ports in the Cloudflare dashboard.
3. **Password Manager:** Register at `vault.yourdomain.xyz`, then set `SIGNUPS_ALLOWED=false` in the compose file and restart.
4. **Connect Arrs:** In Prowlarr, add your indexers and sync to Radarr. In Radarr, add qBittorrent as the download client.

---

#### **4. WhatsApp Automation Workflow (n8n)**

To order movies via WhatsApp, follow this logic in n8n:

1. **Trigger:** `WhatsApp Business Cloud` (On Message Received).
2. **Code Node:** Use a simple Regex to find the IMDb ID (`tt\d{7,8}`) from your message.
3. **HTTP Request Node:**
* **Method:** `POST`
* **URL:** `http://radarr:7878/api/v3/movie`
* **Headers:** `X-Api-Key: YOUR_RADARR_API_KEY`
* **Body (JSON):**
```json
{
  "tmdbId": 0, 
  "title": "Movie Title", 
  "qualityProfileId": 1, 
  "rootFolderPath": "/movies", 
  "addOptions": { "searchForMovie": true }
}

```


*(Note: You'll typically map the IMDb ID retrieved from step 2 to Radarr's lookup endpoint first to get the correct metadata before the final POST).*
