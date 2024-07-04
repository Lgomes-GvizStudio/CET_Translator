<?php
function translate($text, $targetIndex = 1, $sourceIndex = 0) {
    // Language codes mapping based on the provided index
    $languages = [
        0 => 'pl',   // Polish
        1 => 'en',   // English
        2 => 'es',   // Spanish
        3 => 'fr',   // French
        4 => 'it',   // Italian
        5 => 'de',   // German
        6 => 'es-419', // Spanish (Latin America)
        7 => 'ko',   // Korean
        8 => 'zh-CN', // Chinese (Simplified)
        9 => 'ru',   // Russian
        10 => 'pt-BR', // Portuguese (Brazilian)
        11 => 'ja',  // Japanese
        12 => 'zh-TW', // Chinese (Traditional)
        13 => 'ar',  // Arabic
        14 => 'cs',  // Czech
        15 => 'hu',  // Hungarian
        16 => 'tr',  // Turkish
        17 => 'th',  // Thai
        18 => 'uk'   // Ukrainian
    ];

    // Validate input indices
    if (!isset($languages[$sourceIndex]) || !isset($languages[$targetIndex])) {
        return "Error: Invalid language index.";
    }

    $source = $languages[$sourceIndex];
    $target = $languages[$targetIndex];

    // Replace spaces with '+' for URL formatting
    $text = urlencode($text);

    // URL for Google Translate
    $url = "https://translate.google.com/m?hl=$target&sl=$source&q=$text";

    // Execute cURL command and capture the output
    $response = shell_exec("curl -s \"$url\"");

    // Use regex to extract the translation
    preg_match('/<div[^>]*class="(?:result-container|t0)"[^>]*>(.*?)<\/div>/i', $response, $matches);

    if (!isset($matches[1])) {
        return "Error: Translation not found.";
    }

    // Return the translated text
    return htmlspecialchars_decode($matches[1]);
}

// Check if command-line arguments are provided
if (isset($argv[1]) && isset($argv[2])) {
    $text_to_translate = isset($argv[3]) ? $argv[3] : "Hello, how are you?";
    $sourceIndex = (int)$argv[1]; // Source language index from command line
    $targetIndex = (int)$argv[2]; // Target language index from command line

    $translated_text = translate($text_to_translate, $targetIndex, $sourceIndex);
    // echo "Original: $text_to_translate\n";
    echo  $translated_text;
} else {
    echo "Usage: php translate.php <source_index> <target_index> [text_to_translate]\n";
}
?>
