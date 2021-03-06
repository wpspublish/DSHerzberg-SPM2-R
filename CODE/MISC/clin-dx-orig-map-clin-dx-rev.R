dx_recode_out <- dx_recode_in %>%
  mutate_at(vars(clin_dx), ~
    case_when(
      clin_dx == 'Autism' ~ 'ASD',
      clin_dx == 'autism, SI/PD comorbid' ~ 'SPD',
      clin_dx == 'Birth Weight: Low birth weight (< 5lb 8oz (2500g)) & Premature birth (< 37 weeks)' ~ 'LBW',
      clin_dx == 'Birth Weight: Low birth weight (< 5lb 8oz (2500g)), Small for gestational age (< 2SD below mean) & Premature birth (< 37 weeks)' ~ 'LBW',
      clin_dx == 'Blindness' ~ 'VIS',
      clin_dx == 'Cerebral palsy; SLP' ~ 'MO',
      clin_dx == 'Chronic Lung Disease; DCD' ~ 'OTH',
      clin_dx == 'Developmental Coordination Disorder' ~ 'MO',
      clin_dx == 'Down syndrome' ~ 'ID',
      clin_dx == 'Down Syndrome' ~ 'ID',
      clin_dx == 'Down Syndrome; SLP' ~ 'ID',
      clin_dx == 'FASD' ~ 'FASD',
      clin_dx == 'Hearing Impairment' ~ 'HEA',
      clin_dx == 'Hearing loss' ~ 'HEA',
      clin_dx == 'IDD_Mild' ~ 'ID',
      clin_dx == 'LBW, Premature Birth' ~ 'LBW',
      clin_dx == 'Low Birth Weight ( < 5lb 8oz (2500g))' ~ 'LBW',
      clin_dx == 'motor impaired - motor delay' ~ 'MO',
      clin_dx == 'muscular Hypotonia' ~ 'MO',
      clin_dx == 'SI/PD' ~ 'SPD',
      clin_dx == 'SLP' ~ 'SLP',
      clin_dx == 'SLP: Langauge Disorder' ~ 'SLP',
      clin_dx == 'Small for gestational age (< 2SD below mean)' ~ 'LBW',
      clin_dx == 'Specific developmental disorder of motor function' ~ 'MO',
      clin_dx == 'Speech-Language Pathology' ~ 'SLP',
      clin_dx == 'Speech-Language Pathology; Language Disorder' ~ 'SLP',
      clin_dx == 'Stickler Syndrome, SLP' ~ 'SLP',
      clin_dx == 'Torticollis, hypotonia, idd-severe' ~ 'ID',
      clin_dx == 'Trisomy 21, Hypotonia, DCD' ~ 'ID',
      clin_dx == 'Unilateral hearing loss due to a congenital malformation of his right ear (microtia/atresia)' ~ 'HEA',
      clin_dx == 'ADHD' ~ 'ADHD',
      clin_dx == 'ADHD, language delay' ~ 'ADHD',
      clin_dx == 'ADHD,Speech Delay' ~ 'ADHD',
      clin_dx == 'ASD' ~ 'ASD',
      clin_dx == 'autism' ~ 'ASD',
      clin_dx == 'Autism' ~ 'ASD',
      clin_dx == 'Autism ADHD' ~ 'ASD',
      clin_dx == 'Autism spectrum disorder' ~ 'ASD',
      clin_dx == 'Autism Spectrum Disorder' ~ 'ASD',
      clin_dx == 'behavioral disorder' ~ 'MH',
      clin_dx == 'Bilateral sensorineural hearing loss' ~ 'HEA',
      clin_dx == 'Blind' ~ 'VIS',
      clin_dx == 'Cerebral Palsy' ~ 'MO',
      clin_dx == 'Childhood Apraxia of speech' ~ 'SLP',
      clin_dx == 'DCD' ~ 'MO',
      clin_dx == 'Deaf and hypotonia' ~ 'HEA',
      clin_dx == 'Delayed development' ~ 'DD',
      clin_dx == 'Developmental coordination disorder' ~ 'MO',
      clin_dx == 'developmental delay' ~ 'DD',
      clin_dx == 'Developmental delay' ~ 'DD',
      clin_dx == 'developmental delays due to premature birth' ~ 'DD',
      clin_dx == 'Developmental Disability' ~ 'DD',
      clin_dx == 'developmentally delayed' ~ 'DD',
      clin_dx == 'Developmentally delayed' ~ 'DD',
      clin_dx == 'FASD' ~ 'FASD',
      clin_dx == 'Front lobe/excessive functioning deficit; Lack of coordination, muscle weakness, Other D/O of nervous system; Expressive Language Disorder, Childhood onset stuttering' ~ 'SLP',
      clin_dx == 'Hearing impaired' ~ 'HEA',
      clin_dx == 'Hearing Impairment' ~ 'HEA',
      clin_dx == 'Hearing loss' ~ 'HEA',
      clin_dx == 'Hearing loss, Microtia of left ear.' ~ 'HEA',
      clin_dx == 'IDD_Mild' ~ 'ID',
      clin_dx == 'moderate/severe autism, and pediatric epilepsy' ~ 'ASD',
      clin_dx == 'Nystagmu, Optic Atrophy/Hypempia' ~ 'VIS',
      clin_dx == 'PTSD' ~ 'MH',
      clin_dx == 'PTSD, RAD' ~ 'MH',
      clin_dx == 'Sensorineural hearing loss' ~ 'HEA',
      clin_dx == 'SI/PD' ~ 'SPD',
      clin_dx == 'SLP' ~ 'SLP',
      clin_dx == 'SLP: Language Disorder' ~ 'SLP',
      clin_dx == 'SLP: Language Disorder & Speech Sound Disorder' ~ 'SLP',
      clin_dx == 'SLP: Speech Sound Disorder' ~ 'SLP',
      clin_dx == 'Spastic CP' ~ 'MO',
      clin_dx == 'speech language pathology' ~ 'SLP',
      clin_dx == 'Treacher Collins syndrome' ~ 'OTH',
      clin_dx == 'Unilaterally deaf' ~ 'HEA',
      clin_dx == 'Visual Impairment' ~ 'VIS',
      clin_dx == 'ADHD' ~ 'ADHD',
      clin_dx == 'ADHD and ODD' ~ 'ADHD',
      clin_dx == 'ASD' ~ 'ASD',
      clin_dx == 'Autism' ~ 'ASD',
      clin_dx == 'Autism Spectrum Disorder' ~ 'ASD',
      clin_dx == 'Autism, developmental delay' ~ 'ASD',
      clin_dx == 'Autistic Spectrum Disorder' ~ 'ASD',
      clin_dx == 'Cerebral Palsy' ~ 'MO',
      clin_dx == 'cleft lip (repaired); SLP' ~ 'SLP',
      clin_dx == 'conductive hearing loss' ~ 'HEA',
      clin_dx == 'CP/Motor Impairment' ~ 'MO',
      clin_dx == 'DCD' ~ 'MO',
      clin_dx == 'deaf' ~ 'HEA',
      clin_dx == 'Deaf or Hard of Hearing' ~ 'HEA',
      clin_dx == 'developmental delay' ~ 'DD',
      clin_dx == 'Developmental delay' ~ 'DD',
      clin_dx == 'Developmental Delay' ~ 'DD',
      clin_dx == 'developmental delay, strabismus' ~ 'DD',
      clin_dx == 'Developmental Disability' ~ 'DD',
      clin_dx == 'FASD' ~ 'FASD',
      clin_dx == 'Front lobe/excessive functioning deficit; Lack of coordination, muscle weakness, Other D/O of nervous system; Expressive Language Disorder, Childhood onset stuttering' ~ 'SLP',
      clin_dx == 'has a developmental delay' ~ 'DD',
      clin_dx == 'Hearing impaired' ~ 'HEA',
      clin_dx == 'Hearing Impairment' ~ 'HEA',
      clin_dx == 'hearing loss' ~ 'HEA',
      clin_dx == 'Hearing loss' ~ 'HEA',
      clin_dx == 'Hearing Loss' ~ 'HEA',
      clin_dx == 'HOH' ~ 'OTH',
      clin_dx == 'IDD_Mild' ~ 'ID',
      clin_dx == 'non-verbal autistic' ~ 'ASD',
      clin_dx == 'Nystagmus, Optic Atrophy/Hypempia' ~ 'VIS',
      clin_dx == 'PTSD' ~ 'MH',
      clin_dx == 'sensory processing' ~ 'SPD',
      clin_dx == 'Sensory Processing Disorder' ~ 'SPD',
      clin_dx == 'SI/PD' ~ 'SPD',
      clin_dx == 'SLP' ~ 'SLP',
      clin_dx == 'SLP: Language Disorder' ~ 'SLP',
      clin_dx == 'SLP: Language Disorder & Speech Sound Disorder' ~ 'SLP',
      clin_dx == 'SLP: Speech Sound Disorder' ~ 'SLP',
      clin_dx == 'Speech language pathology' ~ 'SLP',
      clin_dx == 'speech pathology' ~ 'SLP',
      clin_dx == 'Speech/Language Impairment' ~ 'SLP',
      clin_dx == 'Treacher Collins Syndrome' ~ 'OTH',
      clin_dx == 'Vision impaired / blind' ~ 'VIS',
      clin_dx == 'Visual Impairment' ~ 'VIS',
      clin_dx == 'ADD, and Autism' ~ 'ASD',
      clin_dx == 'ADD, Dyslexia' ~ 'ADHD',
      clin_dx == 'Adhd' ~ 'ADHD',
      clin_dx == 'ADHD' ~ 'ADHD',
      clin_dx == 'ADHD cerebral palsy' ~ 'MO',
      clin_dx == 'ADHD with delayed learning' ~ 'LD',
      clin_dx == 'ADHD, Anxiety' ~ 'ADHD',
      clin_dx == 'ADHD, dyslexia' ~ 'ADHD',
      clin_dx == 'ADHD, dyslexia, anxiety' ~ 'ADHD',
      clin_dx == 'ADHD, emotional disorder' ~ 'ADHD',
      clin_dx == 'ADHD, ODD' ~ 'ADHD',
      clin_dx == 'adhd, sensory disorder' ~ 'SPD',
      clin_dx == 'Anx' ~ 'MH',
      clin_dx == 'anxiety' ~ 'MH',
      clin_dx == 'Anxiety' ~ 'MH',
      clin_dx == 'anxiety disorder, adhd' ~ 'ADHD',
      clin_dx == 'anxiety, PTSD' ~ 'MH',
      clin_dx == 'Aprixia, dyspraxia and low muscle tone' ~ 'MO',
      clin_dx == 'ASD' ~ 'ASD',
      clin_dx == 'ASD, ADHD' ~ 'ASD',
      clin_dx == 'ASD/PDD' ~ 'ASD',
      clin_dx == 'Austism' ~ 'ASD',
      clin_dx == 'autism' ~ 'ASD',
      clin_dx == 'Autism' ~ 'ASD',
      clin_dx == 'autism & ADHD, heart condition' ~ 'ASD',
      clin_dx == 'Autism Spectrum' ~ 'ASD',
      clin_dx == 'Autism spectrum disorder' ~ 'ASD',
      clin_dx == 'Autism Spectrum Disorder' ~ 'ASD',
      clin_dx == 'Autism, ADHD' ~ 'ASD',
      clin_dx == 'autism, ADHD, anxiety, sensory processing disorder' ~ 'ASD',
      clin_dx == 'Autism, Anxiety' ~ 'ASD',
      clin_dx == 'Autism, anxiety, ocd, ADHD, Chromosone 14 duplication' ~ 'ASD',
      clin_dx == 'Autism, Intellectually Delayed, Expressive Receptive Speech Disorder' ~ 'ASD',
      clin_dx == 'autism,developmentally delayed' ~ 'ASD',
      clin_dx == 'Behavior' ~ 'MH',
      clin_dx == 'Bilateral sensorineural hearing loss' ~ 'HEA',
      clin_dx == 'Bilateral sensroinerural hearing loss' ~ 'HEA',
      clin_dx == 'Bipolar' ~ 'MH',
      clin_dx == 'Cerebral Palsy' ~ 'MO',
      clin_dx == 'Cerebral palsy and Hearing Impairment' ~ 'MO',
      clin_dx == 'Cerebral Palsy, Deaf with Cochlear Implants' ~ 'MO',
      clin_dx == 'Colorectal issues celiac, adhd' ~ 'ADHD',
      clin_dx == 'Cortical vision impairment' ~ 'VIS',
      clin_dx == 'Cystic fibrosis ADHD' ~ 'ADHD',
      clin_dx == 'DCD' ~ 'MO',
      clin_dx == 'Deaf' ~ 'HEA',
      clin_dx == 'Deaf (Cochlear Implants), Low Muscle Tone, Incoordination, GERD' ~ 'HEA',
      clin_dx == 'Deaf Hard of Hearing (Cochlear Implant Recipient)' ~ 'HEA',
      clin_dx == 'Deaf with CI' ~ 'HEA',
      clin_dx == 'depression, anxiety' ~ 'MH',
      clin_dx == 'Developmental Coordination Disorder' ~ 'MO',
      clin_dx == 'Developmental Delay' ~ 'DD',
      clin_dx == 'Developmental delay, autism, non verbal' ~ 'ASD',
      clin_dx == 'developmentally delayed' ~ 'DD',
      clin_dx == 'Down syndrome' ~ 'ID',
      clin_dx == 'Down Syndrome' ~ 'ID',
      clin_dx == 'Down syndrome, Autism' ~ 'ASD',
      clin_dx == 'Down Syndrome/Trisomy 21' ~ 'ID',
      clin_dx == 'Dysthymia, ADHD, anxiety' ~ 'MH',
      clin_dx == 'emotional disability' ~ 'MH',
      clin_dx == 'emotional disturbance, ODD' ~ 'MH',
      clin_dx == 'Epilepsy' ~ 'OTH',
      clin_dx == 'Fatty Acid Oxidation Disorder' ~ 'OTH',
      clin_dx == 'Fetal Alcohol Syndrome, ADHD, Autism' ~ 'FASD',
      clin_dx == 'Golden Har Syndrome' ~ 'OTH',
      clin_dx == 'hearing impairment' ~ 'HEA',
      clin_dx == 'Hearing Impairment' ~ 'HEA',
      clin_dx == 'Hearing Loss' ~ 'HEA',
      clin_dx == 'High Functioning Autism' ~ 'ASD',
      clin_dx == 'IDD_Mild' ~ 'ID',
      clin_dx == 'IDD_Moderate' ~ 'ID',
      clin_dx == 'Intellectual Disability' ~ 'ID',
      clin_dx == 'Language Disorder' ~ 'SLP',
      clin_dx == 'LD' ~ 'LD',
      clin_dx == 'Learning Disability' ~ 'LD',
      clin_dx == 'Legally blind' ~ 'VIS',
      clin_dx == 'Mental delays learning' ~ 'LD',
      clin_dx == 'Mental learning disability' ~ 'LD',
      clin_dx == 'moderate to severe hearing loss' ~ 'HEA',
      clin_dx == 'Mood' ~ 'MH',
      clin_dx == 'Mood/behavior' ~ 'MH',
      clin_dx == 'Mood/Intellectual Disability' ~ 'ID',
      clin_dx == 'ODD and ADHD' ~ 'MH',
      clin_dx == 'PPD/NOS  ADHD' ~ 'ADHD',
      clin_dx == 'Profound Hearing Loss' ~ 'HEA',
      clin_dx == 'Profoundly Deaf' ~ 'HEA',
      clin_dx == 'Sensory Intergration Disorder, Erbspalsy, Mild Estatic Encampanthaty, Right Hands Klumpksy, etc.' ~ 'SPD',
      clin_dx == 'sensory intergration issues' ~ 'SPD',
      clin_dx == 'Sensory processing disorder' ~ 'SPD',
      clin_dx == 'Sensory Processing Disorder' ~ 'SPD',
      clin_dx == 'sensory processing issues' ~ 'SPD',
      clin_dx == 'SI/PD' ~ 'SPD',
      clin_dx == 'SI/PD Comorbid' ~ 'SPD',
      clin_dx == 'SI/PD, ADHD' ~ 'SPD',
      clin_dx == 'SLP' ~ 'SLP',
      clin_dx == 'SLP-Speech Sound Disorder' ~ 'SLP',
      clin_dx == 'SLP: Language Disorder & Speech Sound Disorder' ~ 'SLP',
      clin_dx == 'Spastic diplegia CP, EoE, FPIES, GAD, medical PTSD, legally blind, deaf in L ear' ~ 'MO',
      clin_dx == 'Spastic Quadriplegic Cerebral Palsy ,Non Verbal, Non Mobile  CVI, Hydrocyphls' ~ 'MO',
      clin_dx == 'SPD' ~ 'SPD',
      clin_dx == 'Specific Learning Disability' ~ 'LD',
      clin_dx == 'Speech and Language' ~ 'SLP',
      clin_dx == 'speech and language impairment' ~ 'SLP',
      clin_dx == 'Speech and Language Impairment' ~ 'SLP',
      clin_dx == 'Speech and Language impairment-language' ~ 'SLP',
      clin_dx == 'Speech and Language Pathology-language & SSD' ~ 'SLP',
      clin_dx == 'speech language impairment' ~ 'SLP',
      clin_dx == 'Speech Language Impairment-articulation' ~ 'SLP',
      clin_dx == 'Speech or Language Impairment' ~ 'SLP',
      clin_dx == 'Stroke at birth; left hemiplegia' ~ 'MO',
      clin_dx == 'Traumatic brain injury' ~ 'TBI',
      clin_dx == 'ADHD' ~ 'ADHD',
      clin_dx == 'ADHD and Sensory Processing' ~ 'SPD',
      clin_dx == 'ADHD cerebral palsy' ~ 'MO',
      clin_dx == 'ADHD, Anxiety' ~ 'ADHD',
      clin_dx == 'ADHD, anxiety, learning difficulties' ~ 'ADHD',
      clin_dx == 'ADHD, ASD' ~ 'ASD',
      clin_dx == 'ADHD, learning difficulties' ~ 'LD',
      clin_dx == 'ADHD; Disgraphia' ~ 'ADHD',
      clin_dx == 'ADHD/Autism' ~ 'ASD',
      clin_dx == 'ADHD/Dyslexia probable' ~ 'ADHD',
      clin_dx == 'anxiety' ~ 'MH',
      clin_dx == 'Anxiety' ~ 'MH',
      clin_dx == 'Anxiety, ADHD, sensory issues' ~ 'SPD',
      clin_dx == 'ASD' ~ 'ASD',
      clin_dx == 'autism' ~ 'ASD',
      clin_dx == 'Autism' ~ 'ASD',
      clin_dx == 'autism and downs syndrome' ~ 'ASD',
      clin_dx == 'Autism Spectrum Disorder' ~ 'ASD',
      clin_dx == 'Autism with Communication Impairment' ~ 'ASD',
      clin_dx == 'autism, adhd' ~ 'ASD',
      clin_dx == 'Autism, Expressive/Receptive Language Deficit, Other Health Impairment (school diagnosis)' ~ 'ASD',
      clin_dx == 'Autism, Pica, ADHD' ~ 'ASD',
      clin_dx == 'Autism, sensory processing disorder' ~ 'ASD',
      clin_dx == 'Autism, Specific Learning Disability in math and reading' ~ 'ASD',
      clin_dx == 'Behavior' ~ 'MH',
      clin_dx == 'Bipolar' ~ 'MH',
      clin_dx == 'Cerebral Palsy' ~ 'MO',
      clin_dx == 'Cerebral Palsy, Eosinophilic Esophogitis, FPIES, Emotional disorder, visual impairment, auditory impairment' ~ 'SPD',
      clin_dx == 'cerebral palsy, hydrocephalus, significant developmental delay, cortical visual impairment, and epilepsy' ~ 'MO',
      clin_dx == 'cortical visual impairment' ~ 'VIS',
      clin_dx == 'DCD' ~ 'MO',
      clin_dx == 'DD/ID' ~ 'DD',
      clin_dx == 'Deaf' ~ 'HEA',
      clin_dx == 'Deaf, wears cochlear implants' ~ 'HEA',
      clin_dx == 'Developmental Coordination Disorder; Dyspraxia' ~ 'MO',
      clin_dx == 'Developmental delay' ~ 'DD',
      clin_dx == 'Developmental Delay' ~ 'DD',
      clin_dx == 'Developmental Disability' ~ 'DD',
      clin_dx == 'Down Syndrome' ~ 'ID',
      clin_dx == 'Emotional' ~ 'MH',
      clin_dx == 'Emotional Disturbance' ~ 'MH',
      clin_dx == 'Emotional Disturbance, PTSD' ~ 'MH',
      clin_dx == 'Erb\'s Palsy' ~ 'OTH',
      clin_dx == 'Fatty Acid Oxidation Disorder, SI/PD' ~ 'SPD',
      clin_dx == 'Fetal alcohol syndrome, attention deficit hyperactivity disorder, autism' ~ 'FASD',
      clin_dx == 'Hard of hearing, Hearing aid, missing right ear from birth' ~ 'HEA',
      clin_dx == 'Hearing impaired' ~ 'HEA',
      clin_dx == 'Hearing Impairment' ~ 'HEA',
      clin_dx == 'hearing loss' ~ 'HEA',
      clin_dx == 'Hearing loss' ~ 'HEA',
      clin_dx == 'Hearing Loss' ~ 'HEA',
      clin_dx == 'HI' ~ 'MO',
      clin_dx == 'ID-DD' ~ 'ID',
      clin_dx == 'IDD' ~ 'ID',
      clin_dx == 'IDD_Mild' ~ 'ID',
      clin_dx == 'IDD_Moderate' ~ 'ID',
      clin_dx == 'Intellectual Disability' ~ 'ID',
      clin_dx == 'Intellectual Disability and Other Health Impairment' ~ 'ID',
      clin_dx == 'Language Disorder' ~ 'SLP',
      clin_dx == 'LD' ~ 'LD',
      clin_dx == 'Learning Disability' ~ 'LD',
      clin_dx == 'moderate intellectual disability, speech and language impairments' ~ 'ID',
      clin_dx == 'Mood' ~ 'MH',
      clin_dx == 'Mood Disorder' ~ 'MH',
      clin_dx == 'Mood/behavior' ~ 'MH',
      clin_dx == 'Mood/Intellectual disability' ~ 'ID',
      clin_dx == 'Non verbal, chairfast' ~ 'OTH',
      clin_dx == 'ODD, emotional disturbance' ~ 'MH',
      clin_dx == 'profound deafness' ~ 'HEA',
      clin_dx == 'profoundly deaf' ~ 'HEA',
      clin_dx == 'PTSD, anxiety' ~ 'MH',
      clin_dx == 'right middle cerebral artery stroke with left sided weakness' ~ 'MO',
      clin_dx == 'SDD- Significantly Developmentally Delayed, & Speech Impairment' ~ 'DD',
      clin_dx == 'Seizure disorder, MI' ~ 'OTH',
      clin_dx == 'Sensory Integration/Processing Disorder' ~ 'SPD',
      clin_dx == 'sensory processing disorder' ~ 'SPD',
      clin_dx == 'Sensory Processing Disorder' ~ 'SPD',
      clin_dx == 'Sesory Processing Disorder Co-Morbid' ~ 'SPD',
      clin_dx == 'SI/PD' ~ 'SPD',
      clin_dx == 'SI/PD, ADHD' ~ 'SPD',
      clin_dx == 'SI/PD, VI' ~ 'SPD',
      clin_dx == 'significant developmental delay' ~ 'DD',
      clin_dx == 'SLP' ~ 'SLP',
      clin_dx == 'SLP: Language Disorder' ~ 'SLP',
      clin_dx == 'SLP: Language Disorder & Speech Sound Disorder' ~ 'SLP',
      clin_dx == 'SPD' ~ 'SPD',
      clin_dx == 'Specific Learning Disability' ~ 'LD',
      clin_dx == 'Specific learning disability. Speech and language impairment' ~ 'LD',
      clin_dx == 'Speech and Language' ~ 'SLP',
      clin_dx == 'speech and language impairment' ~ 'SLP',
      clin_dx == 'Speech and Language impairment-language' ~ 'SLP',
      clin_dx == 'Speech disorder' ~ 'SLP',
      clin_dx == 'Speech or Language Impairment' ~ 'SLP',
      clin_dx == 'Speech/Language' ~ 'SLP',
      clin_dx == 'speech/language impairment' ~ 'SLP',
      clin_dx == 'Traumatic Brain Injury' ~ 'TBI',
      clin_dx == 'Visually impaired' ~ 'VIS',
      clin_dx == 'adhd' ~ 'ADHD',
      clin_dx == 'Adhd' ~ 'ADHD',
      clin_dx == 'ADHD' ~ 'ADHD',
      clin_dx == 'ADHD and ASD' ~ 'ASD',
      clin_dx == 'ADHD, Aspergers, Mood Disorder, Sleep Disorder, Anxiety Disorder' ~ 'ASD',
      clin_dx == 'adhd, autism' ~ 'ASD',
      clin_dx == 'ADHD, autism' ~ 'ASD',
      clin_dx == 'ADHD, Dysgraphia' ~ 'ADHD',
      clin_dx == 'ADHD, OCD, Anxiety Disorder, ASD' ~ 'ADHD',
      clin_dx == 'anxiety' ~ 'MH',
      clin_dx == 'Anxiety' ~ 'MH',
      clin_dx == 'anxiety, ADHD, autism' ~ 'ASD',
      clin_dx == 'ASD' ~ 'ASD',
      clin_dx == 'ASD, ADHD, anxiety' ~ 'ASD',
      clin_dx == 'ASD, Anxiety, depression' ~ 'ASD',
      clin_dx == 'autism' ~ 'ASD',
      clin_dx == 'Autism' ~ 'ASD',
      clin_dx == 'Autism Spectrum Disorder' ~ 'ASD',
      clin_dx == 'Autism, ADHD, Anxiety' ~ 'ASD',
      clin_dx == 'Autism, Anxiety, Depression, OCD, DMDD' ~ 'ASD',
      clin_dx == 'autism,seizures' ~ 'ASD',
      clin_dx == 'bipolar, autism danny walkers' ~ 'ASD',
      clin_dx == 'Blind, Cerebral Palsy' ~ 'VIS',
      clin_dx == 'Cancer, ASD, anxiety, depression, post pardon trauma, brain cyst' ~ 'ASD',
      clin_dx == 'cerebral palsy' ~ 'MO',
      clin_dx == 'CP, ASD' ~ 'MO',
      clin_dx == 'depression' ~ 'MH',
      clin_dx == 'Depression' ~ 'MH',
      clin_dx == 'Depression, anxiety' ~ 'MH',
      clin_dx == 'depression, PTSD' ~ 'MH',
      clin_dx == 'Down syndrome' ~ 'ID',
      clin_dx == 'Down Syndrome' ~ 'ID',
      clin_dx == 'Dyslexia and ADHD' ~ 'ADHD',
      clin_dx == 'FASD' ~ 'FASD',
      clin_dx == 'FASD Developmental Delay ASD' ~ 'FASD',
      clin_dx == 'Hearing impaired' ~ 'HEA',
      clin_dx == 'Hearing Impaired' ~ 'HEA',
      clin_dx == 'hearing loss' ~ 'HEA',
      clin_dx == 'Hearing loss' ~ 'HEA',
      clin_dx == 'hemiplegia, cp' ~ 'MO',
      clin_dx == 'IDD' ~ 'ID',
      clin_dx == 'Intellectual Disability Moderate' ~ 'ID',
      clin_dx == 'LD' ~ 'LD',
      clin_dx == 'Learning Disability' ~ 'LD',
      clin_dx == 'Mild CP' ~ 'MO',
      clin_dx == 'Mood Disorder' ~ 'MH',
      clin_dx == 'Oppositional Defient Disoder and ADHD' ~ 'ADHD',
      clin_dx == 'pFAS (partial Fetal alcohol syndrome, has all facial, behavioral, and sensory dx, but is missing the 2nd growth lag required for a full FASD diagnoses)' ~ 'FASD',
      clin_dx == 'ptsd' ~ 'MH',
      clin_dx == 'PTSD, ODD' ~ 'MH',
      clin_dx == 'SLP' ~ 'SLP',
      clin_dx == 'SLP: Language Disorder' ~ 'SLP',
      clin_dx == 'SLP: Language Disorder & Speech Sound Disorder' ~ 'SLP',
      clin_dx == 'spastic diplegia, cerebral palsy, Periventricular leukomalacia, asthma, non-verbal learning disorder' ~ 'MO',
      clin_dx == 'syndactily and adhd' ~ 'ADHD',
      clin_dx == 'TBI' ~ 'TBI',
      clin_dx == 'traumatic brain injury' ~ 'TBI',
      clin_dx == 'Traumatic Brain injury' ~ 'TBI',
      clin_dx == '299.00 Autism Spectrum Disorder (F84.0) Level 2 Requiring Substantial Support with social communication impairments; Level 2 Requiring substantial support with restricted, repetitive behaviors; without accompanying intellectual impairment. With accompanying language impairment deficits in social communication, exhibits little clin_dxiation in intonation and difficulties with voice quality. Has been diagnosed with anxiety.' ~ 'ASD',
      clin_dx == 'ADD/ADHD' ~ 'ADHD',
      clin_dx == 'ADHD' ~ 'ADHD',
      clin_dx == 'ADHD, birth defect right hand, missing middle finger' ~ 'ADHD',
      clin_dx == 'ADHD, Dyslexia' ~ 'ADHD',
      clin_dx == 'ADHD, learning difficulties' ~ 'LD',
      clin_dx == 'anxiety' ~ 'MH',
      clin_dx == 'Anxiety' ~ 'MH',
      clin_dx == 'Anxiety, OCD' ~ 'MH',
      clin_dx == 'ASD' ~ 'ASD',
      clin_dx == 'ASD PDD-NOS' ~ 'ASD',
      clin_dx == 'ASD, ADHD' ~ 'ASD',
      clin_dx == 'ASD; Hard of hearing in his right ear (not sure what the specific diagnosis is called).' ~ 'ASD',
      clin_dx == 'Austism, ADHD, OCD, Anxiety Disorder' ~ 'ASD',
      clin_dx == 'Autism' ~ 'ASD',
      clin_dx == 'Autism Spectrum Disorder' ~ 'ASD',
      clin_dx == 'Autism Spectrum Disorder, ADHD' ~ 'ASD',
      clin_dx == 'Autism Spectrum Disorder, Emotional / Behavioral DIsorder' ~ 'ASD',
      clin_dx == 'Autism, Other Health Impairment' ~ 'ASD',
      clin_dx == 'Blindness, Cerebral Palsy' ~ 'VIS',
      clin_dx == 'Cerebral Palsy' ~ 'MO',
      clin_dx == 'CEREBRAL PALSY' ~ 'MO',
      clin_dx == 'Cerebral Palsy, ADHD' ~ 'MO',
      clin_dx == 'Cerebral Palsy, Autism Spectrum Disorder' ~ 'ASD',
      clin_dx == 'CP' ~ 'MO',
      clin_dx == 'depression' ~ 'MH',
      clin_dx == 'Depression' ~ 'MH',
      clin_dx == 'Diagnosed with Asperger\'s disorder with features of anxiety, Attention Deficit Hyperactivity Disorder combined type and Mixed expressive and receptive language disorder.' ~ 'ASD',
      clin_dx == 'Emotional / Behavioral Disorder' ~ 'MH',
      clin_dx == 'FASD' ~ 'FASD',
      clin_dx == 'Fetal Alcohol Syndrome, ADHD' ~ 'ADHD',
      clin_dx == 'Hearing Impaired' ~ 'HEA',
      clin_dx == 'HOH' ~ 'OTH',
      clin_dx == 'IDD_Mild' ~ 'ID',
      clin_dx == 'Intellectual disability' ~ 'ID',
      clin_dx == 'Intellectual Disability Moderate' ~ 'ID',
      clin_dx == 'language disorder (expressive), learning disorders' ~ 'SLP',
      clin_dx == 'language disorder, learning disorders (reading, writing)' ~ 'SLP',
      clin_dx == 'Learning disability' ~ 'LD',
      clin_dx == 'Learning Disability' ~ 'LD',
      clin_dx == 'Mild Intellectual Disability and Speech and Language Impaired' ~ 'ID',
      clin_dx == 'Mood Disorder' ~ 'MH',
      clin_dx == 'POTS, ASD' ~ 'ASD',
      clin_dx == 'profound hearing loss' ~ 'HEA',
      clin_dx == 'PTSD' ~ 'MH',
      clin_dx == 'PTSD, depression' ~ 'MH',
      clin_dx == 'PTSD, ODD' ~ 'MH',
      clin_dx == 'SLP' ~ 'SLP',
      clin_dx == 'SLP: Language Disorder' ~ 'SLP',
      clin_dx == 'SLP: Language Disorder & Speech Sound Disorder' ~ 'SLP',
      clin_dx == 'SLP: Speech Sound Disorder' ~ 'SLP',
      clin_dx == 'SPD' ~ 'SPD',
      clin_dx == 'Specific Learning Disability' ~ 'LD',
      clin_dx == 'TBI' ~ 'TBI',
      clin_dx == 'Traumatic brain injury' ~ 'TBI',
      clin_dx == 'Traumatic Brain Injury' ~ 'TBI',
      clin_dx == 'adhd' ~ 'ADHD',
      clin_dx == 'ADHD' ~ 'ADHD',
      clin_dx == 'ADHD, ASD' ~ 'ASD',
      clin_dx == 'adhd, autism' ~ 'ASD',
      clin_dx == 'ADHD, OCD, Anxiety Disorder, ASD' ~ 'ADHD',
      clin_dx == 'Adhd, sensory processing disorder, auditory processing disorder' ~ 'SPD',
      clin_dx == 'anxiety' ~ 'MH',
      clin_dx == 'Anxiety' ~ 'MH',
      clin_dx == 'Anxiety disorder' ~ 'MH',
      clin_dx == 'ASD' ~ 'ASD',
      clin_dx == 'ASD, ADHD, anxiety' ~ 'ASD',
      clin_dx == 'autism' ~ 'ASD',
      clin_dx == 'Autism' ~ 'ASD',
      clin_dx == 'Autism Spectrum Disorder' ~ 'ASD',
      clin_dx == 'Autism-ADHD' ~ 'ASD',
      clin_dx == 'autism, adhd, and hearing loss' ~ 'ASD',
      clin_dx == 'autism, ADHD, anxiety' ~ 'ASD',
      clin_dx == 'Autism, ADHD, Anxiety' ~ 'ASD',
      clin_dx == 'Autism, Anxiety, Depression, OCD, DMDD' ~ 'ASD',
      clin_dx == 'Behavioral Disorder' ~ 'MH',
      clin_dx == 'Blind, cerebral palsy' ~ 'VIS',
      clin_dx == 'Cancer, ASD, anxiety, depression, post pardon trauma, brain cyst' ~ 'ASD',
      clin_dx == 'Cerebral Palsy' ~ 'MO',
      clin_dx == 'dandy walkers syndrome, behavioral disorder' ~ 'OTH',
      clin_dx == 'Deaf' ~ 'HEA',
      clin_dx == 'depression' ~ 'MH',
      clin_dx == 'Depression' ~ 'MH',
      clin_dx == 'depression, anxiety' ~ 'MH',
      clin_dx == 'Dyslexia, Autism Spectrum Disorder, SLP' ~ 'ASD',
      clin_dx == 'dyslexia, language disorder' ~ 'SLP',
      clin_dx == 'dyslexia, language disorder, IDD_Mild' ~ 'ID',
      clin_dx == 'FASD' ~ 'FASD',
      clin_dx == 'Hearing' ~ 'HEA',
      clin_dx == 'Hearing loss' ~ 'HEA',
      clin_dx == 'High functioning autism' ~ 'ASD',
      clin_dx == 'Intellectual Disability Moderate' ~ 'ID',
      clin_dx == 'Learning Disability' ~ 'LD',
      clin_dx == 'mild CP' ~ 'MO',
      clin_dx == 'Mood Disorder' ~ 'MH',
      clin_dx == 'Periventricular leukomalacia, ADD, non verbal learning disorder' ~ 'ASD',
      clin_dx == 'pFASD, ADHD' ~ 'FASD',
      clin_dx == 'PTSD' ~ 'MH',
      clin_dx == 'sld' ~ 'SLP',
      clin_dx == 'SLD' ~ 'SLP',
      clin_dx == 'SLP' ~ 'SLP',
      clin_dx == 'SLP: Language Disorder' ~ 'SLP',
      clin_dx == 'SLP: Language Disorder & Speech Sound Disorder' ~ 'SLP',
      clin_dx == 'TBI' ~ 'TBI',
      clin_dx == 'Traumatic Brain Injury' ~ 'TBI',
      clin_dx == 'Traumaticbraininjury' ~ 'TBI',
      clin_dx == 'ADHD' ~ 'ADHD',
      clin_dx == 'ADHD: Inattentive Presentation' ~ 'ADHD',
      clin_dx == 'Anxiety' ~ 'MH',
      clin_dx == 'Anxiety, panic disorder and agoraphobia' ~ 'MH',
      clin_dx == 'ASD' ~ 'ASD',
      clin_dx == 'ASD, fibromyalgia, Hashimoto\'s Syndrome' ~ 'ASD',
      clin_dx == 'Attention Deficit Hyperactivity Disorder, Behavioral Disorder, FASD' ~ 'FASD',
      clin_dx == 'Autism Spectrum Disorder (leaning towards Asperger\'s)' ~ 'ASD',
      clin_dx == 'bi polar' ~ 'MH',
      clin_dx == 'Cerebral Palsy' ~ 'MO',
      clin_dx == 'Chiari Malformation, Occipital Neuralgia, anxiety, depression' ~ 'MH',
      clin_dx == 'CP' ~ 'MO',
      clin_dx == 'deaf in right ear; atypical hemolytic uremia syndrome' ~ 'HEA',
      clin_dx == 'depression' ~ 'MH',
      clin_dx == 'Depression' ~ 'MH',
      clin_dx == 'Depression, anxiety, ADHD' ~ 'MH',
      clin_dx == 'Depression, PTSD, idiopathic hypersomnia, sleep apnea' ~ 'MH',
      clin_dx == 'Developmental Delay' ~ 'DD',
      clin_dx == 'Down syndrome' ~ 'ID',
      clin_dx == 'dyscalcula, ADD' ~ 'ADHD',
      clin_dx == 'FASD' ~ 'FASD',
      clin_dx == 'Heading loss' ~ 'HEA',
      clin_dx == 'Hearing Impairment' ~ 'HEA',
      clin_dx == 'Hearing Loss' ~ 'HEA',
      clin_dx == 'ID' ~ 'ID',
      clin_dx == 'IDD' ~ 'ID',
      clin_dx == 'LD' ~ 'LD',
      clin_dx == 'LD: Mathematics' ~ 'LD',
      clin_dx == 'LD: Reading' ~ 'LD',
      clin_dx == 'LD: Reading and Written Expression' ~ 'LD',
      clin_dx == 'LD: Reading, Written Expression and Mathematics' ~ 'LD',
      clin_dx == 'LD: Written Expression' ~ 'LD',
      clin_dx == 'Learning disability' ~ 'LD',
      clin_dx == 'Learning Disability - Mild ADHD' ~ 'LD',
      clin_dx == 'Leber\'s Optic Neuropathy' ~ 'VIS',
      clin_dx == 'Mood Disorder' ~ 'MH',
      clin_dx == 'P.T.S.D.' ~ 'MH',
      clin_dx == 'Reading and writing disorder' ~ 'SLP',
      clin_dx == 'Sensory processing' ~ 'SPD',
      clin_dx == 'SI/PD' ~ 'SPD',
      clin_dx == 'SIPD' ~ 'SPD',
      clin_dx == 'SLP' ~ 'SLP',
      clin_dx == 'SLP: Language Disorder' ~ 'SLP',
      clin_dx == 'TBI' ~ 'TBI',
      clin_dx == 'TBI and depression' ~ 'TBI',
      clin_dx == 'TBI due to a motorcycle wreck and paralysis' ~ 'MO',
      clin_dx == 'TBI, no right temporal lobe; migraines and epilepsy' ~ 'TBI',
      clin_dx == 'Traumatic Brain Injury, anxiety' ~ 'TBI',
      clin_dx == 'Visual Impairment' ~ 'VIS',
      clin_dx == 'adhd' ~ 'ADHD',
      clin_dx == 'ADHD' ~ 'ADHD',
      clin_dx == 'ADHD, high functioning autism' ~ 'ASD',
      clin_dx == 'ADHD: Inattentive Presentation' ~ 'ADHD',
      clin_dx == 'Anxiety' ~ 'MH',
      clin_dx == 'Anxiety, panic disorder, agoraphobia' ~ 'MH',
      clin_dx == 'ASD' ~ 'ASD',
      clin_dx == 'Attention Deficit Hyperactivity Disorder, Behavioral Disorder, FASD' ~ 'FASD',
      clin_dx == 'autism' ~ 'ASD',
      clin_dx == 'Autism' ~ 'ASD',
      clin_dx == 'Autism and Depressive Disorder' ~ 'ASD',
      clin_dx == 'Autism spectrum, ADHD' ~ 'ASD',
      clin_dx == 'Bilateral hearing loss' ~ 'HEA',
      clin_dx == 'bipolar' ~ 'MH',
      clin_dx == 'Cerebral palsy' ~ 'MO',
      clin_dx == 'Cerebral Palsy' ~ 'MO',
      clin_dx == 'CP' ~ 'MO',
      clin_dx == 'depression' ~ 'MH',
      clin_dx == 'Depression' ~ 'MH',
      clin_dx == 'Down syndrome' ~ 'ID',
      clin_dx == 'F33.1, F41.0 F43.10 COPD and TBI' ~ 'OTH',
      clin_dx == 'FASD' ~ 'FASD',
      clin_dx == 'hearing impairment' ~ 'HEA',
      clin_dx == 'Hearing Impairment' ~ 'HEA',
      clin_dx == 'Intellectual disability' ~ 'ID',
      clin_dx == 'Intellectual Disability' ~ 'ID',
      clin_dx == 'Intellectual Disability Disorder' ~ 'ID',
      clin_dx == 'LD' ~ 'LD',
      clin_dx == 'LD: Mathematics' ~ 'LD',
      clin_dx == 'LD: Reading' ~ 'LD',
      clin_dx == 'LD: Reading and Written Expression' ~ 'LD',
      clin_dx == 'LD: Reading, Written Expression and Mathematics' ~ 'LD',
      clin_dx == 'LD: Written Expression' ~ 'LD',
      clin_dx == 'Learning Disability' ~ 'LD',
      clin_dx == 'Learning disorder in reading' ~ 'LD',
      clin_dx == 'Leber\'s Optic Neuropathy' ~ 'VIS',
      clin_dx == 'Mild intellectual disability' ~ 'ID',
      clin_dx == 'Mood Disorder' ~ 'MH',
      clin_dx == 'permanent injury - atypical hemolytic uremic syndrome' ~ 'OTH',
      clin_dx == 'recent TBI, anxiety' ~ 'MH',
      clin_dx == 'sensory processing' ~ 'SPD',
      clin_dx == 'Sensory processing' ~ 'SPD',
      clin_dx == 'SI/PD' ~ 'SPD',
      clin_dx == 'SLP' ~ 'SLP',
      clin_dx == 'SLP: Language Disorder' ~ 'SLP',
      clin_dx == 'Supra vavular aurta stenosis' ~ 'OTH',
      clin_dx == 'TBI' ~ 'TBI',
      clin_dx == 'TBI and depression' ~ 'TBI',
      clin_dx == 'TBI and quadriplegic paralysis' ~ 'TBI',
      clin_dx == 'Traumatic brain injury (last 3-4 months), anxiety' ~ 'TBI',
      clin_dx == 'Visual Impairment' ~ 'VIS',
      T ~ 'OTH'
    )
  )
