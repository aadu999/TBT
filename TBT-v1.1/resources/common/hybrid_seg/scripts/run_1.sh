sh src/clean.sh
make -B
sh src/create_directories.sh

cd hmm/
cat syldict | cut -d " " -f2- > temp
cp syldict syldict_without_context
sed -e 's/beg\-//g' -i syldict_without_context
sed -e 's/\_end//g' -i syldict_without_context
sed -e 's/\s\+/\n/g' -i temp
sort -u temp > phonelist
cat syldict_without_context | cut -d " " -f2- > temp
sed -e 's/\s\+/\n/g' -i temp
sort -u temp > phonelist_without_context
cd ../
cp hmm/syldict_without_context dict_with_end
sed -e 's/$/ end/' -i dict_with_end
cp Phonelist_Description/Vowels hmm/vowels

cd hmm/
echo "Downsampling Wavefiles to 8KHz for Extracting MFCC's"
ls ../wav_16KHz > wav_list
tcsh scripts/sr_change.sh wav_list
ls wav_8KHz/*.wav > wav_list
ls prompt-lab > list
cp list ../

tcsh scripts/dict.sh phonelist_without_context
tcsh scripts/dict_with_context.sh phonelist
tcsh scripts/map_table.sh wav_list
echo "Extracting MFCC's from 8KHz wavefiles"
sh scripts/extract_feature.sh

sort phonelist_without_context > phonelist_sorted
sort vowels > vowels_sorted
comm -23 phonelist_sorted vowels_sorted > consonants

cd prompt-lab/
sed -i 's/_v//' *
sed -i 's/_iv//' *
sed -i 's/_uv//' *
sed -i 's/_GEM//' *
sed -i 's/_BEG//' *
sed -i 's/_MID//' *
sed -i 's/_END//' *
sed -i 's/_beg//' *
sed -i 's/_mid//' *
sed -i 's/_end//' *
sed -i 's/_bg//' *
sed -i 's/_eg//' *
sed -i 's/-x//' *
cd ../


perl scripts/create_transcription.pl
./createMLF

echo "Pass I completed------->>>"
