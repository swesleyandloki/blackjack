window.appModel = new App()
window.appView = new AppView(model: appModel).$el.appendTo 'body'
