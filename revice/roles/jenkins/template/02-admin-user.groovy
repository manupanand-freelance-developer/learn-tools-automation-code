import jenkins.model.* 
import hudson.security.* 

def instance =Jenkins.getInstance() 
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("{{secrets.admin_user}}","{{secrets.admin_password}}")
instance.setSecurityRealm(hudsonRealm)
instance.save()