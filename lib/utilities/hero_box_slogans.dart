import 'dart:math';

class HeroBoxSlogans {
  static final _random = Random();
  static final List<String> _partnersScreenSlogans = [
    "Discover a New Era of Membership Bliss!",
    "Elevate Your Journey with Unmatched Membership!",
    "Unlock a World of Partnership Perks!",
    "Membership Reimagined Just for You!",
    "Step Into the Future of Exclusive Connections!",
    "Redefine Belonging with Premier Membership!",
    "Experience the Ultimate Partnership Advantage!",
    "Your Membership, Your New Adventure Awaits!",
    "Join the Elite: Membership Beyond the Ordinary!",
    "Transform How You Connect with Membership Magic!",
  ];

  static final List<String> _homeScreenSlogans = [
    "Unleash the Strength of Your Membership!",
    "Feel the Pulse of Exclusive Belonging!",
    "Membership: Your Key to Limitless Possibilities!",
    "Harness the Energy of Elite Access!",
    "Power Up with Unrivaled Membership Benefits!",
    "Ignite Your Potential with Membership Might!",
    "Command the Benefits of Being a Member!",
    "Membership That Packs a Punch!",
    "Tap Into the Force of Exclusive Rewards!",
    "Experience Membership That Empowers You!",
  ];

  static final List<String> _verifyMemberScreenSlogans = [
    "Confirm Your Status, Claim Your Rewards!",
    "Verify Now for a Treasure Trove of Perks!",
    "Unlock the Vault with Membership Verification!",
    "Step Up, Verify, and Revel in Exclusivity!",
    "Your Key to Benefits Awaits Verification!",
    "Authenticate and Access Membership Gold!",
    "Verify Today, Enjoy Elite Privileges Tomorrow!",
    "Seal the Deal: Verify for Exclusive Wins!",
    "Open the Door to Rewards with Verification!",
    "Prove It, Unlock It: Membership Magic Starts Here!",
  ];

  static getHomeScreenSlogan() {
    return _homeScreenSlogans[_random.nextInt(_homeScreenSlogans.length)];
  }

  static getPartnersScreenSlogan() {
    return _partnersScreenSlogans[_random.nextInt(_partnersScreenSlogans.length)];
  }

  static getVerifyMemberScreenSlogan() {
    return _verifyMemberScreenSlogans[_random.nextInt(_verifyMemberScreenSlogans.length)];
  }
}
