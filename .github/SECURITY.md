# Security Policy

Several kits run code on the server and talk to the client through remotes (admin actions, purchases, rewards, trading, donations). A flaw in one of them could let an exploiter give themselves currency, items or admin access in games that use the kit.

## Reporting a vulnerability

Please do not open a public issue for security problems, since that would expose every game using the kit before a fix is available.

Report it privately instead:

1. Go to the **Security** tab of this repository.
2. Click **Report a vulnerability** and describe the problem, the kit affected and how to reproduce it.

You will get a reply as soon as possible, and the fix will be released before the details are made public.

## Scope

- Remote handlers that trust client input
- Purchase, reward or currency flows that can be duplicated or skipped
- Admin or role checks that can be bypassed
- Saving logic that can corrupt or wipe player data
