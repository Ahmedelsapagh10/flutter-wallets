import fs from "fs";
import { PKPass } from "passkit-generator";

const pass = await PKPass.from(
    {
        model: "./model", // folder with pass.json + images
        certificates: {
            wwdr: fs.readFileSync("./certs/AppleWWDRCAG3.pem"),
            signerCert: fs.readFileSync("./certs/signerCert.pem"),
            signerKey: fs.readFileSync("./certs/signerKey.pem"),
            signerKeyPassphrase: "YOUR_P12_PASSWORD"
        }
    },
    {
        serialNumber: "DOMS-001",
        description: "DOMS Wallet Pass",
        organizationName: "DOMS",
        passTypeIdentifier: "pass.com.doms.wallet",
        teamIdentifier: "46A2B2VZ24"
    }
);

fs.writeFileSync("domapp.pkpass", pass.getAsBuffer());
console.log("Created domapp.pkpass");
