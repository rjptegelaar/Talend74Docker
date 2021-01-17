import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()

def unixRealm = new PAMSecurityRealm("ssh")
instance.setSecurityRealm(unixRealm)

instance.setAuthorizationStrategy(new FullControlOnceLoggedInAuthorizationStrategy())

instance.save()