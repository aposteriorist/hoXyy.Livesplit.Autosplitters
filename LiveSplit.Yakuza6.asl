// Yakuza 6 Load Remover by hoxi, contributions by Vojtas131
// with help from rythin_songrequest
// Autosplitter by PlayingLikeAss (aposteriorist on Github)

state("Yakuza6", "Steam")
{
    long FileTimer:  0x25CE288, 0xC78;
    string50 Magic:  0x25D2AA8, 0x38, 0x18, 0x32;
    byte EnemyCount: 0x25D7C80, 0xE00, 0x22;
    byte Loading:    0x25F5280, 0x364;
}

// Same pointers as the current patch, but it's useful for LiveSplit to tell you what patch you're on.
state("Yakuza6", "Steam - Patch 3 (06 May)")
{
    long FileTimer:  0x25CE288, 0xC78;
    string50 Magic:  0x25D2AA8, 0x38, 0x18, 0x32;
    byte EnemyCount: 0x25D7C80, 0xE00, 0x22;
    byte Loading:    0x25F5280, 0x364;
}

state("Yakuza6", "Steam - Patch 2 (21 April)")
{
    long FileTimer:  0x25CE208, 0xC78;
    string50 Magic:  0x25D2A28, 0x38, 0x18, 0x32;
    byte EnemyCount: 0x25D7BF0, 0xE00, 0x22;
    byte Loading:    0x25F5240, 0x364;
}

// Same pointers as Patch 2, but it's useful for LiveSplit to tell you what patch you're on.
state("Yakuza6", "Steam - Patch 1 (12 April)")
{
    long FileTimer:  0x25CE208, 0xC78;
    string50 Magic:  0x25D2A28, 0x38, 0x18, 0x32;
    byte EnemyCount: 0x25D7BF0, 0xE00, 0x22;
    byte Loading:    0x25F5240, 0x364;
}

state("Yakuza6", "Steam - Launch Version")
{
    long FileTimer:  0x25C9F88, 0xC78;
    string50 Magic:  0x25CE7B8, 0x38, 0x18, 0x32;
    byte EnemyCount: 0x25D3980, 0xE00, 0x22;
    byte Loading:    0x25F0FC0, 0x364;
}

state("Yakuza6", "M Store")
{
    long FileTimer:  0x27B9C98, 0xC78;
    string50 Magic:  0x27BE4B0, 0x38, 0x18, 0x32;
    byte EnemyCount: 0x27C36F0, 0xE00, 0x22;
    byte Loading:    0x27E0CA0, 0x364;
}

state("Yakuza6", "GOG")
{
    long FileTimer:  0x282BA88, 0xC78;
    string50 Magic:  0x28302A0, 0x38, 0x18, 0x32;
    byte EnemyCount: 0x28354D0, 0xE00, 0x22;
    byte Loading:    0x2852B20, 0x364;
}

init
{
    switch(modules.First().ModuleMemorySize)
    {
        case 60669952:
            // Every Steam version is this memory size, aside from the launch version.
            // To counter this, we'll check the TimeDateStamp field in the COFF header (file creation date).
            switch(memory.ReadValue<int>(modules.First().BaseAddress + 0x178))
            {
                case 1621853032: // 24th May, 2021
                    // The default version is correct.
                    break;
                case 1619792947: // 30th April, 2021
                    version = "Steam - Patch 3 (06 May)";
                    break;
                case 1618322824: // 13th April, 2021
                    version = "Steam - Patch 2 (21 April)";
                    break;
                case 1617782951: // 7th April, 2021
                    version = "Steam - Patch 1 (12 April)";
                    break;
                default:
                    print(memory.ReadValue<int>(modules.First().BaseAddress + 0x178).ToString());
                    break;
            }
            break;
        case 60653568:
            version = "Steam - Launch Version";
            break;
        case 62541824:
            version = "M Store";
            break;
        case 62947328:
            version = "GOG";
            break;
        default:
            print(modules.First().ModuleMemorySize.ToString());
            break;
    }
}

startup
{
    vars.Splits = new HashSet<string>();
    vars.OngoingFight = "";
    vars.StartPrompt = false;

    settings.Add("CHAPTERS", false, "Chapter End Splits");
        settings.Add("title02", true, "Chapter 1: The Price of Freedom", "CHAPTERS");
        settings.Add("title03", true, "Chapter 2: Life Blooms Anew", "CHAPTERS");
        settings.Add("title04", true, "Chapter 3: Foreign Influence", "CHAPTERS");
        settings.Add("title05", true, "Chapter 4: Deception", "CHAPTERS");
        settings.Add("title06", true, "Chapter 5: Masked", "CHAPTERS");
        settings.Add("title07", true, "Chapter 6: Footsteps", "CHAPTERS");
        settings.Add("title08", true, "Chapter 7: Heihaizi", "CHAPTERS");
        settings.Add("title09", true, "Chapter 8: Conspiracy", "CHAPTERS");
        settings.Add("title10", true, "Chapter 9: Disappearance", "CHAPTERS");
        settings.Add("title11", true, "Chapter 10: Blood Law", "CHAPTERS");
        settings.Add("title12", true, "Chapter 11: Father and Son", "CHAPTERS");
        settings.Add("title13", true, "Chapter 12: The Sleeping Giant", "CHAPTERS");

    settings.Add("FIGHTS", true, "Fight Splits");
        settings.Add("btl01_010", true, "Nagumo 101", "FIGHTS");
        settings.Add("btl01_015", true, "Ch.1: Thugs", "FIGHTS");
        settings.Add("btl01_020", true, "Ch.1: Little Asia", "FIGHTS");
        settings.Add("btl01_030", true, "Ch.1: Alley", "FIGHTS");
        settings.Add("btl01_040", true, "Ch.1: Ed", "FIGHTS");
        settings.Add("btl02_020", true, "Ch.2: Akiyama", "FIGHTS");
        settings.Add("btl03_010", true, "Ch.3: Nagumo", "FIGHTS");
        settings.Add("btl03_030", true, "Ch.3: Baseball Men", "FIGHTS");
        settings.Add("btl03_040", true, "Ch.3: Masuzoe", "FIGHTS");
        settings.Add("btl04_010", true, "Ch.4: Drunk Civilians", "FIGHTS");
        settings.Add("btl04_030", true, "Ch.4: Tagashira & Yuta", "FIGHTS");
        settings.Add("btl04_040", true, "Ch.4: Masuzoe", "FIGHTS");
        settings.Add("btl05_030", true, "Ch.5: Someya", "FIGHTS");
        settings.Add("btl06_010", true, "Ch.6: Jingweon Mafia", "FIGHTS");
        settings.Add("btl06_020", true, "Ch.6: Joon-gi Han", "FIGHTS");
        settings.Add("btl07_040", true, "Ch.7: Ed", "FIGHTS");
        settings.Add("btl08_020", true, "Ch.8: Someya", "FIGHTS");
        settings.Add("btl09_050", true, "Ch.9: Koshimizu", "FIGHTS");
        settings.Add("btl10_010", true, "Ch.10: Men in Black", "FIGHTS");
        settings.Add("btl10_020", true, "Ch.10: Joon-gi Han", "FIGHTS");
        settings.Add("btl10_050", true, "Ch.10: Joon-gi Han (setpiece)", "FIGHTS");
        settings.Add("btl11_020", true, "Ch.11: Ed", "FIGHTS");
        settings.Add("btl11_030", true, "Ch.11: Yuta", "FIGHTS");
        settings.Add("btl12_020", true, "Ch.12: Nagumo", "FIGHTS");
        settings.Add("btl12_070", true, "Ch.12: Hirose", "FIGHTS");
        settings.Add("btl13_050", true, "Finale: Someya", "FIGHTS");
        settings.Add("btl13_060", true, "Finale: Koshimizu", "FIGHTS");
        settings.Add("btl13_070", true, "Finale: Iwami", "FIGHTS");

    settings.Add("SETPIECES", false, "Setpiece Splits (before boss)");
        settings.Add("btl05_020", true, "Ch.5: Hotel", "SETPIECES");
        settings.Add("btl07_030", true, "Ch.7: Little Asia", "SETPIECES");
        settings.Add("btl08_010", true, "Ch.8: Shangri-La", "SETPIECES");
        settings.Add("btl09_010", true, "Ch.9: Onomichi", "SETPIECES");
        settings.Add("btl10_040", true, "Ch.10: Floating Island", "SETPIECES");
        settings.Add("btl11_010", true, "Ch.11: Little Asia", "SETPIECES");
        settings.Add("btl12_010", true, "Ch.12: Onomichi", "SETPIECES");
        settings.Add("btl12_060b", true, "Ch.12: Shipyard", "SETPIECES");
        settings.Add("btl13_020", true, "Finale: Onomichi", "SETPIECES");
        settings.Add("btl13_160", true, "Finale: Millennium Tower", "SETPIECES");

    vars.SetpieceList = new String[10] {
        "btl05_020", "btl07_030", "btl08_010", "btl09_010", "btl10_040", "btl11_010", "btl12_010", "btl12_060b", "btl13_020", "btl13_160"};

    settings.Add("MISC", false, "Other Splits");
        settings.Add("adv01_070", false, "Ch.1: Reaching Kamurocho", "MISC");
        settings.Add("scn02_020", false, "Ch.2: Taxi to Tojo HQ", "MISC");
        settings.Add("adv03_220", false, "Ch.3: Baby Segment", "MISC");
        settings.Add("advcln02_070", false, "Ch.5: After Clan Creator", "MISC");
        settings.Add("adv12_160", false, "Ch.12: Yamano Dodai's Grave", "MISC");

    vars.MiscList = new String[5] { "adv01_070", "scn02_020", "adv03_220", "advcln02_070", "adv12_160" };
}

start
{
    /* The Magic string is taikenban_c01_title throughout the main menu, so we'll use that to orient ourselves.

       When a difficulty is selected and the autosave confirmation screen comes up, IGT resets to 0 and begins counting up.
        (IGT also resets twice throughout the boot splash screens, but those shouldn't false start because of the Magic string.)

       We'll also check if IGT is below 1000, to prevent file loads from false-starting after sitting on the title screen too long.
        (IGT counts above 5000 before the Start confirmation prompt is enabled, so this won't prevent autostart.) */

    vars.StartPrompt |= current.Magic == "taikenban_c01_title" && old.Magic == "taikenban_c01_title"
                     && old.FileTimer > current.FileTimer && current.FileTimer < 1000;

    // Loading occurs on the button press in the Start prompt, so we can use it to autostart.
    return vars.StartPrompt && current.Loading == 1;
}

update
{
    // Debug prints
    // if (current.Magic != old.Magic) print(String.Format("{0} -> {1} ({2})", old.Magic ?? "NULL", current.Magic ?? "NULL", current.FileTimer));
    // if (current.FileTimer < old.FileTimer) print(String.Format("{0}: {1}", current.Magic, current.FileTimer));
}

split
{
    // If we're not tracking a fight, and if the Magic string has changed:
    if (vars.OngoingFight == "" && current.Magic != old.Magic)
    {
        // Is the previous Magic string a setpiece?
        if (Array.IndexOf(vars.SetpieceList, old.Magic) >= 0)
        {
            // Check for continues and Loading a save.
            if (settings["SETPIECES"] && current.Magic != "command_continue" && current.Magic != null)
            {
                // If the setting is enabled, split.
                if (settings.ContainsKey(old.Magic) && settings[old.Magic] && !vars.Splits.Contains(old.Magic))
                {
                    vars.Splits.Add(old.Magic);
                    return true;
                }
            }
        }

        // If the current Magic string is a setpiece, skip it for now.
        else if (Array.IndexOf(vars.SetpieceList, current.Magic) >= 0) return false;

        // Is the current Magic string a checked setting?
        else if (current.Magic != null && settings.ContainsKey(current.Magic) && settings[current.Magic] && !vars.Splits.Contains(current.Magic))
        {
            // Is it a chapter title card? Or a miscellaneous split?
            if (settings["CHAPTERS"] && current.Magic.StartsWith("title") || settings["MISC"] && Array.IndexOf(vars.MiscList, current.Magic) >= 0)
            {
                vars.Splits.Add(current.Magic);
                return true;
            }

            // If not, then we should start tracking a fight.
            //  (We don't need a list of fight splits, but only because we're checking this category last.)
            else if (settings["FIGHTS"])
            {
                vars.OngoingFight = current.Magic;
            }
        }
    }

    // If we're now tracking a fight:
    if (vars.OngoingFight != "")
    {
        // Check the absolute difference on IGT to protect against continues and loading a save mid-fight.
        if (Math.Abs(current.FileTimer - old.FileTimer) > 1000)
        {
            vars.OngoingFight = "";
        }

        // If there were enemies and there are now no more enemies, we're done.
        else if (current.EnemyCount == 0 && old.EnemyCount > 0)
        {
            vars.Splits.Add(vars.OngoingFight);
            vars.OngoingFight = "";
            return true;
        }
    }
}

isLoading
{
    return current.Loading == 1;
}

reset
{
    // When returning to the main menu, IGT resets to 0. But Livesplit sometimes misses the 0, so we'll go low (1/3 sec.).
    //  (IGT never resets during gameplay, but it does decrease when we load a save, so we don't want to simply compare old to current.)

    // We'll also check the Magic string to be unnecessarily thorough.
    //  Splash screens: "boot" -> null -> "title_logo" -> "title_tenth_anniv" (-> "qloc_logo") -> "real_yakuza_pad" -> "taikenban_c01_title"

    return current.FileTimer < 1000 && (current.Magic == "boot" || current.Magic == "title_logo");
}

onReset
{
    vars.Splits.Clear();
    vars.OngoingFight = "";
    vars.StartPrompt = false;
}
