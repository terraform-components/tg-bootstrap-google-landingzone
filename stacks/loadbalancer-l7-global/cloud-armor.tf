# # https://cloud.google.com/armor/docs/rule-tuning

# # just added all level 1 as example
# # adjust to needs

# resource "google_compute_security_policy" "main" {
#   name = format(local.name_format["global"], var.name)

#   rule {
#     action   = "deny(403)"
#     priority = "1000"
#     match {
#       expr {
#         expression = <<EOF
#         evaluatePreconfiguredExpr('xss-v33-stable',
#         ['owasp-crs-v030301-id941150-xss',
#           'owasp-crs-v030301-id941320-xss',
#           'owasp-crs-v030301-id941330-xss',
#           'owasp-crs-v030301-id941340-xss',
#           'owasp-crs-v030301-id941380-xss'
#         ])
#         EOF
#       }
#     }
#     description = "Prevent cross site scripting attacks"
#   }

#   rule {
#     action   = "deny(403)"
#     priority = "2000"
#     match {
#       expr {
#         expression = <<EOF
#         evaluatePreconfiguredExpr('sqli-v33-stable',
#         ['owasp-crs-v030301-id942110-sqli',
#           'owasp-crs-v030301-id942120-sqli',
#           'owasp-crs-v030301-id942130-sqli',
#           'owasp-crs-v030301-id942150-sqli',
#           'owasp-crs-v030301-id942180-sqli',
#           'owasp-crs-v030301-id942200-sqli',
#           'owasp-crs-v030301-id942210-sqli',
#           'owasp-crs-v030301-id942260-sqli',
#           'owasp-crs-v030301-id942300-sqli',
#           'owasp-crs-v030301-id942310-sqli',
#           'owasp-crs-v030301-id942330-sqli',
#           'owasp-crs-v030301-id942340-sqli',
#           'owasp-crs-v030301-id942361-sqli',
#           'owasp-crs-v030301-id942370-sqli',
#           'owasp-crs-v030301-id942380-sqli',
#           'owasp-crs-v030301-id942390-sqli',
#           'owasp-crs-v030301-id942400-sqli',
#           'owasp-crs-v030301-id942410-sqli',
#           'owasp-crs-v030301-id942470-sqli',
#           'owasp-crs-v030301-id942480-sqli',
#           'owasp-crs-v030301-id942430-sqli',
#           'owasp-crs-v030301-id942440-sqli',
#           'owasp-crs-v030301-id942450-sqli',
#           'owasp-crs-v030301-id942510-sqli',
#           'owasp-crs-v030301-id942251-sqli',
#           'owasp-crs-v030301-id942490-sqli',
#           'owasp-crs-v030301-id942420-sqli',
#           'owasp-crs-v030301-id942431-sqli',
#           'owasp-crs-v030301-id942460-sqli',
#           'owasp-crs-v030301-id942511-sqli',
#           'owasp-crs-v030301-id942421-sqli',
#           'owasp-crs-v030301-id942432-sqli']
#         )
#         EOF
#       }
#     }
#     description = "Prevent sql injection attacks"
#   }

#   rule {
#     action   = "deny(403)"
#     priority = "3000"
#     match {
#       expr {
#         expression = <<EOF
#         evaluatePreconfiguredExpr('rce-v33-stable',
#         ['owasp-crs-v030301-id932200-rce',
#           'owasp-crs-v030301-id932106-rce',
#           'owasp-crs-v030301-id932190-rce'])
#         EOF
#       }
#     }
#     description = "Prevent remote code execution"
#   }

#   rule {
#     action   = "deny(403)"
#     priority = "4000"
#     match {
#       expr {
#         expression = <<EOF

#         evaluatePreconfiguredExpr('lfi-v33-canary')

#         EOF
#       }
#     }
#     description = "Local file inclusion (LFI)"
#   }

#   rule {
#     action   = "deny(403)"
#     priority = "5000"
#     match {
#       expr {
#         expression = <<EOF

#         evaluatePreconfiguredExpr('rfi-v33-canary', ['owasp-crs-v030301-id931130-rfi'])

#         EOF
#       }
#     }
#     description = "Remote file inclusion (RFI)"
#   }

#   rule {
#     action   = "deny(403)"
#     priority = "6000"
#     match {
#       expr {
#         expression = <<EOF

#         evaluatePreconfiguredExpr('methodenforcement-v33-stable')

#         EOF
#       }
#     }
#     description = "Method enforcement"
#   }

#   rule {
#     action   = "deny(403)"
#     priority = "7000"
#     match {
#       expr {
#         expression = <<EOF

#         evaluatePreconfiguredExpr('scannerdetection-v33-stable',
#           ['owasp-crs-v030301-id913101-scannerdetection',
#           'owasp-crs-v030301-id913102-scannerdetection']
#         )

#         EOF
#       }
#     }
#     description = "Scanner detection"
#   }

#   rule {
#     action   = "deny(403)"
#     priority = "8000"
#     match {
#       expr {
#         expression = <<EOF

#         evaluatePreconfiguredExpr('protocolattack-v33-stable',
#           ['owasp-crs-v030301-id921151-protocolattack',
#           'owasp-crs-v030301-id921170-protocolattack']
#         )

#         EOF
#       }
#     }
#     description = "Protocol attack"
#   }

#   # rule {
#   #   action   = "deny(403)"
#   #   priority = "9000"
#   #   match {
#   #     expr {
#   #       expression = <<EOF

#   #       evaluatePreconfiguredExpr('php-v33-stable',
#   #       ['owasp-crs-v030301-id933151-php',
#   #         'owasp-crs-v030301-id933131-php',
#   #         'owasp-crs-v030301-id933161-php',
#   #         'owasp-crs-v030301-id933111-php',
#   #         'owasp-crs-v030301-id933190-php']
#   #       )

#   #       EOF
#   #     }
#   #   }
#   #   description = "PHP"
#   # }

#   rule {
#     action   = "deny(403)"
#     priority = "10000"
#     match {
#       expr {
#         expression = <<EOF

#         evaluatePreconfiguredExpr('sessionfixation-v33-canary')

#         EOF
#       }
#     }
#     description = "Session fixation"
#   }

#   rule {
#     action   = "deny(403)"
#     priority = "11000"
#     match {
#       expr {
#         expression = <<EOF

#         evaluatePreconfiguredExpr('cve-canary', 
#         ['owasp-crs-v030001-id244228-cve', 'owasp-crs-v030001-id344228-cve']
#         )

#         EOF
#       }
#     }
#     description = "CVE"
#   }

#   rule {
#     action   = "deny(403)"
#     priority = "12000"
#     match {
#       expr {
#         expression = <<EOF

#         evaluateThreatIntelligence('iplist-tor-exit-nodes')

#         EOF
#       }
#     }
#     description = "Threat Intel TOR Nodes"
#   }

#   rule {
#     action   = "deny(403)"
#     priority = "13000"
#     match {
#       expr {
#         expression = <<EOF

#         evaluateThreatIntelligence('iplist-known-malicious-ips')

#         EOF
#       }
#     }
#     description = "Threat Intel Malicious IPs"
#   }

#   rule {
#     action   = "deny(403)"
#     priority = "14000"
#     match {
#       expr {
#         expression = <<EOF

#         evaluateThreatIntelligence('iplist-search-engines-crawlers')

#         EOF
#       }
#     }
#     description = "Threat Intel Search Engine Crawlers"
#   }

#   rule {
#     action   = "allow"
#     priority = "2147483647"
#     match {
#       versioned_expr = "SRC_IPS_V1"
#       config {
#         src_ip_ranges = ["*"]
#       }
#     }
#     description = "default rule"
#   }
# }
