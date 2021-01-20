terraform {
	backend "remote" {
		organization = "KATA-FRIDAYS"
		workspaces {
			name = "automate-all-the-things-pi"
		}
	}
}
