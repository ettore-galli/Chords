module Core.ChordCalculator where

    import Core.Model
    import Core.KnownInstruments

    {-|
    Given a string and a fret, apply the fingering to the string.
    -}
    applyFingeringOnTunedString :: TunedString -- ^ The string on which to apply the fingering
                                -> Fingering   -- ^ The finfering to apply
                                -> TunedString -- ^ The resulting string, with fingering applied
    applyFingeringOnTunedString t Nothing = t
    applyFingeringOnTunedString (TunedString tuning fg) (Just n) = TunedString tuning (Just n) 


    {-|
    Given an instrument, string number and fret build the set of fingerings 
    to apply to a full instrument, i.e. a list of Nothing(s) but the fingering
    received in input.
    -} 
    prepareFingerings :: Instrument     -- ^ The template instrument
                        -> Int          -- ^ The string number
                        -> Fingering    -- ^ The fingering to apply
                        -> [Fingering]  -- ^ The list of fingerings, i.e. no fingerings (Nothing) except for the string specified
    prepareFingerings instrument strn fingering = prepareFingeringsRun instrument strn fingering 1
        where    
            prepareFingeringsRun :: Instrument -> Int -> Fingering -> Int -> [Fingering]
            prepareFingeringsRun [] _ _ _ = [] 
            prepareFingeringsRun (s:ss) strn fingering progr = (if strn == progr then fingering else Nothing) : (prepareFingeringsRun ss strn fingering (progr + 1))

    {-|
    Given an instrument, string number and fret and and a corresponding list of frets, apply the fingering(s) to the instrument.
    -}
    applyFingeringsOnInstrument :: Instrument   -- ^ The instrument on which to apply the fingering
                                -> [Fingering]  -- ^ The list of fingerings to apply
                                -> Instrument   -- ^ The instrument, with fingerings applied
    applyFingeringsOnInstrument [] _ = []
    applyFingeringsOnInstrument _ [] = []
    applyFingeringsOnInstrument (s:ss) (f:fs) = (applyFingeringOnTunedString s f) : (applyFingeringsOnInstrument ss fs)

    {-|
    Given a list of tunings, instantiate an instrument
    -}
    parseInstrumentFromTunings :: [Tuning] -> Instrument
    parseInstrumentFromTunings tunings = map (\t -> TunedString t Nothing) tunings


    findIntervalOnTunedString :: TunedString -> Interval -> TunedString
    findIntervalOnTunedString string interval = undefined

    findIntervalOnInstrument :: Instrument -> Interval -> Instrument
    findIntervalOnInstrument instrument interval = undefined

    addIntervalToTuningtry :: Tuning -> Interval -> Tuning
    addIntervalToTuningtry a b = a + b 