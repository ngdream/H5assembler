export default {
    lang: "en-Us",
    title: 'H5assembler',
    outlineTitle: 'In hac pagina',
    titleTemplate: "Code satic html pages without repeating yourself",
    description: 'Code satic html pages without repeating yourself',
    appearance: "dark",
    cleanUrls: 'with-subfolders',
    themeConfig: {
        siteTitle: 'H5assembler',
        logo: { src: "/icon.png", alt: "H5assembler logo" },
        nav: [
            { text: 'Guide', link: '/guide/', activeMatch: '/guide/' },
            { text: 'Usage', link: '/usage/', activeMatch: '/usage/' },
            { text: 'Changelog', link: 'https://github.com/ngdream/H5assembler/releases' }
        ],
        socialLinks: [
            { icon: 'github', link: 'https://github.com/ngdream/H5assembler' },
            { icon: 'discord', link: 'https://discord.com/invite/CDxcsNTE' },

        ],
        editLink: {
            pattern: 'https://github.com/ngdream/H5assembler/tree/main/documentation',
            text: 'Edit this page on GitHub'
        },
        lastUpdated: true,
        lastUpdatedText: 'Updated Date',
        docFooter: {
            prev: 'Previous',
            next: 'Next'
        },
        footer: {
            message: 'Released under the MIT License.',
            copyright: 'Copyright © 2022-present Ngdream'
        }
    }
}