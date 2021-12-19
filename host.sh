#!bin/bash

echo " "
echo "Clean..."

rm -f host lite_host lite_adblocker adblocker lite_dnsmasq.conf dnsmasq.conf deadallow deadblock checkblock checkallow smartdns.conf lite_smartdns.conf doamin lite_domain

echo " "
echo "Merge allow..."
for url in `cat allowlist` ;do
    wget --no-check-certificate -t 1 -T 10 -q -O tmp $url
    cat tmp >> tmpallow
    rm -f tmp
done

sed -i '/]/d' tmpallow
sed -i '/#/d' tmpallow
sed -i '/\!/d' tmpallow
sed -i 's/127.0.0.1 //' tmpallow
sed -i 's/https:\/\///' tmpallow
sed -i 's/http:\/\///' tmpallow
sed -i 's/pp助手淘宝登录授权拉起//' tmpallow
sed -i 's/只要有这一条，//' tmpallow
sed -i 's/，腾讯视频网页下一集按钮灰色，也不能选集播放//' tmpallow
sed -i 's/会导致腾讯动漫安卓版的逗比商城白屏//' tmpallow
sed -i '/address/d' tmpallow
sed -i '/REG ^/d' tmpallow
sed -i '/RZD/d' tmpallow
sed -i 's/ALL ./ /g' tmpallow
sed -i '/^$/d' tmpallow
sed -i s/[[:space:]]//g tmpallow
sort -u tmpallow > allow
rm -f tmpallow

echo " "
echo "Check Dead Allow..."
cp allow checkallow
wget --no-check-certificate -t 1 -T 10 -q https://raw.githubusercontent.com/neodevpro/dead-allow/master/deadallow
sort -n allow deadallow deadallow | uniq -u > tmp && mv tmp tmpallow
sort -u tmpallow > allow
rm -f tmpallow

echo " "
echo "Merge block..."
for url in `cat blocklist` ;do
    wget --no-check-certificate -t 1 -T 10 -q -O tmp $url
    cat tmp >> tmpblock
    rm -f tmp
done

sed -i '/#/d' tmpblock
sed -i '/255.255.255.255/d' tmpblock
sed -i '/ip6-/d' tmpblock
sed -i '/local/d' tmpblock
sed -i '/{/d' tmpblock
sed -i '/]/d' tmpblock
sed -i '/}/d' tmpblock
sed -i '/\!/d' tmpblock
sed -i 's/@@//' tmpblock
sed -i 's/*//' tmpblock
sed -i 's/0.0.0.0 //' tmpblock
sed -i 's/0.0.0.0//' tmpblock
sed -i 's/127.0.0.1 //' tmpblock
sed -i 's/||//' tmpblock
sed -i 's/\^adshow//' tmpblock
sed -i 's/\^showAd//' tmpblock
sed -i 's/\^ad//' tmpblock
sed -i 's/\^tracker\^//' tmpblock
sed -i 's/:443//' tmpblock
sed -i 's/\^//' tmpblock
sed -i 's/|//' tmpblock
sed -i 's/$important//' tmpblock
sed -i 's/$badfilter//' tmpblock
sed -i 's/:://' tmpblock
sed -i 's/:\/\///' tmpblock
sed -i 's/^\.//' tmpblock
sed -i 's/^\-//' tmpblock
sed -i 's/:\/\///' tmpblock
sed -i '/*/d' tmpblock
sed -i '/^$/d' tmpblock
sed -i s/[[:space:]]//g tmpblock
sort -u tmpblock > block
rm -f tmpblock

echo " "
echo "Check Dead Block..."
cp block checkblock
cp block lite_block
wget --no-check-certificate -t 1 -T 10 -q https://raw.githubusercontent.com/FusionPlmH/dead-block/master/deadblock
sort -n lite_block deadblock deadblock | uniq -u > tmp && mv tmp tmplite_block
sort -u tmplite_block > lite_block
rm -f tmplite_block 

echo " "
echo "Merge Combine..."
sort -n block allow allow | uniq -u > tmp && mv tmp tmphost
sort -u tmphost > host
sed -i '/^$/d' host
sed -i s/[[:space:]]//g host
rm -f tmphost

echo " "
echo "Merge Combine..."
sort -n lite_block allow allow | uniq -u > tmp && mv tmp tmplite_host
sort -u tmplite_host > lite_host
sed -i '/^$/d' lite_host
sed -i s/[[:space:]]//g lite_host
rm -f tmplite_host

echo " "
echo "Adding Compatibility..."

cp host adblocker
cp host dnsmasq.conf
cp host smartdns.conf
cp host domain

cp lite_host lite_adblocker
cp lite_host lite_dnsmasq.conf
cp lite_host lite_smartdns.conf
cp lite_host lite_domain


sed -i 's/^/||&/' adblocker
sed -i 's/$/&^/' adblocker 

sed -i 's/^/||&/' lite_adblocker
sed -i 's/$/&^/' lite_adblocker 

sed -i 's/^/0.0.0.0  &/' host

sed -i 's/^/0.0.0.0  &/' lite_host

sed -i 's/^/address=\/&/' dnsmasq.conf 

sed -i 's/$/&\/0.0.0.0/' dnsmasq.conf  

sed -i 's/^/address=\/&/' lite_dnsmasq.conf 

sed -i 's/$/&\/0.0.0.0/' lite_dnsmasq.conf 

sed -i 's/^/address \/&/' smartdns.conf 

sed -i 's/$/&\/#/' smartdns.conf  

sed -i 's/^/address \/&/' lite_smartdns.conf 

sed -i 's/$/&\/#/' lite_smartdns.conf 

echo " "
echo "Adding Title and SYNC data..."
sed -i '14cTotal ad / tracking block list 屏蔽追踪广告总数: '$(wc -l block)' ' README.md  
sed -i '16cTotal allowlist list 允许名单总数: '$(wc -l allow)' ' README.md 
sed -i '18cTotal combine list 结合总数： '$(wc -l host)' ' README.md
sed -i '20cTotal deadblock list 失效屏蔽广告域名： '$(wc -l deadblock)' ' README.md
sed -i '22cTotal deadallow list 失效允许广告域名： '$(wc -l deadallow)' ' README.md
sed -i '24cUpdate 更新时间: '$(date "+%Y-%m-%d")'' README.md

sed -i '54cNumber of Domain 域名数目： '$(wc -l domain)' ' README.md
sed -i '65cNumber of Domain 域名数目： '$(wc -l lite_domain)' ' README.md

 
cp title title.2
sed -i '9c# Last update: '$(date "+%Y-%m-%d")'' title.2 
sed -i '11c# Number of blocked domains:  '$(wc -l host)' ' title.2  
cp title title.4
sed -i '9c# Last update: '$(date "+%Y-%m-%d")'' title.4 
sed -i '11c# Number of blocked domains:  '$(wc -l adblocker)' ' title.4
cp title title.6
sed -i '9c# Last update: '$(date "+%Y-%m-%d")'' title.6
sed -i '11c# Number of blocked domains:  '$(wc -l dnsmasq.conf)' ' title.6
cp title title.8
sed -i '9c# Last update: '$(date "+%Y-%m-%d")'' title.8
sed -i '11c# Number of blocked domains:  '$(wc -l smartdns.conf)' ' title.8    
cp title title.10
sed -i '9c# Last update: '$(date "+%Y-%m-%d")'' title.10
sed -i '11c# Number of blocked domains:  '$(wc -l domain)' ' title.10             




cp title title.1
sed -i '9c# Last update: '$(date "+%Y-%m-%d")'' title.1
sed -i '11c# Number of blocked domains:  '$(wc -l lite_host)' ' title.1   
cp title title.3
sed -i '9c# Last update: '$(date "+%Y-%m-%d")'' title.3
sed -i '11c# Number of blocked domains:  '$(wc -l lite_adblocker)' ' title.3   
cp title title.5
sed -i '9c# Last update: '$(date "+%Y-%m-%d")'' title.5
sed -i '11c# Number of blocked domains:  '$(wc -l lite_dnsmasq.conf)' ' title.5  
cp title title.7
sed -i '9c# Last update: '$(date "+%Y-%m-%d")'' title.7
sed -i '11c# Number of blocked domains:  '$(wc -l lite_smartdns.conf)' ' title.7  
cp title title.9
sed -i '9c# Last update: '$(date "+%Y-%m-%d")'' title.9
sed -i '11c# Number of blocked domains:  '$(wc -l lite_domain)' ' title.9  


cat host >>title.2
cat adblocker >>title.4
cat dnsmasq.conf >>title.6
cat smartdns.conf >>title.8
cat domain >>title.10

cat lite_host >>title.1
cat lite_adblocker >>title.3
cat lite_dnsmasq.conf >>title.5
cat lite_smartdns.conf >>title.7
cat lite_domain >>title.9

rm -f host adblocker dnsmasq.conf lite_host lite_adblocker lite_dnsmasq.conf deadallow deadblock allow lite_block block smartdns.conf lite_smartdns.conf doamin lite_domain

mv title.2 host
mv title.4 adblocker
mv title.6 dnsmasq.conf
mv title.8 smartdns.conf
mv title.10 domain

mv title.1 lite_host
mv title.3 lite_adblocker
mv title.5 lite_dnsmasq.conf
mv title.7 lite_smartdns.conf
mv title.9 lite_domain

echo " "
echo "Done!"
