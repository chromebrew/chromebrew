var NEWTERM = 'chrome-untrusted://crosh/',
    OLDTERM = 'chrome-extension://nkoccljplnhpfnfiajclkommnmllphnl/html/crosh.html';
chrome.runtime.sendMessage('nkoccljplnhpfnfiajclkommnmllphnl', null, null, (response) => {
    if (chrome.runtime.lastError) {
        chrome.tabs.update({url: NEWTERM})
    } else {
        chrome.tabs.update({url: OLDTERM})
    }
})
